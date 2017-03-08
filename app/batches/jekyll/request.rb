require 'net/http'

class Jekyll::Request < Rails::Generators::Base
  def self.run
    new.execute
  end

  def execute
    User.all.each do |user|
      u_dir = "#{Rails.root}/tmp/user_#{user.id}"
      unless Dir.glob("#{u_dir}/_posts/*.markdown").present?
        commit_name = "Update article #{Date.today.to_s}"
        branch_name = generate_branch_name
        run "cd #{u_dir} && git checkout -b #{branch_name}"
        export_articles(user)
        run "cd #{u_dir} && git add ."
        run "cd #{u_dir} && git commit -m '#{commit_name}'"
        run "cd #{u_dir} && git push origin #{branch_name}"
        send_pull_request(user, commit_name, branch_name)
      end
    end
  end

  def export_articles(user)
    user.articles.each do |article|
      if article.status?
        u_dir = "#{Rails.root}/tmp/user_#{user.id}"
        f = File.open("#{u_dir}/_posts/#{article.created_at.to_s.split(' ').first}-#{article.title}.md", 'w')
        f.print front_matter(article.title)
        f.print article.content
        f.close
      end
    end
  end

  private

    def application_name
      Rails.application.class.name.split('::').first.underscore
    end

    def generate_branch_name
      "#{application_name}-#{Date.today.to_s}-#{SecureRandom.uuid}"
    end

    def front_matter(title)
      <<"EOS"
---
layout: post
title: #{title}
---
EOS
    end

    def send_pull_request(user, commit, branch)
      uri = URI.parse("https://api.github.com/repos/#{user.username}/#{user.github_repository.name}/pulls")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.path)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "token #{user.github_access_token.access_token}"
      req.body = {
        "title" => commit,
        "head" => branch,
        "base" => "master"
      }.to_json
      res = http.request(req)
    end
end
