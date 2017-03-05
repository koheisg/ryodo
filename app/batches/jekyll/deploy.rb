class Jekyll::Deploy < Rails::Generators::Base
  def self.run
    new.execute
  end

  def execute
    User.all.each do |user|
      if user.github_access_token && user.github_repository
        u_dir = "#{Rails.root}/tmp/user_#{user.id}/"
        remote_name = "remote-#{user.username}"
        commit_name = "sample"
        run "jekyll new #{u_dir}"
        run "cd #{u_dir}"
        git remote: "add #{remote_name} git@github.com:#{user.username}/#{user.github_repository.name}.git"
        git remote: "set-url #{remote_name} git@github.com:#{user.username}/#{user.github_repository.name}.git"
        git add: "-f #{u_dir}*"
        run "cd tmp/#{user.id} && git add ."
        git commit: " -m '#{commit_name}'"
        git push: "-f #{remote_name} master"
      end
    end
  end

  private
    def application_name
      Rails.application.class.name.split('::').first.underscore
    end

    def branch_name
      "#{application_name}-#{Date.today.to_s}-#{SecureRandom.uuid}"
    end
end