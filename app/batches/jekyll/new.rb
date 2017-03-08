class Jekyll::New < Rails::Generators::Base
  def self.run
    new.execute
  end

  def execute
    User.all.each do |user|
      if user.github_access_token && user.github_repository
        u_dir = "#{Rails.root}/tmp/user_#{user.id}"
        if run "cd #{u_dir}" && !run "cd #{u_dir}/_posts"
          run "cd #{u_dir} && jekyll new ./"
          run "rm -f #{u_dir}/_posts/*.markdown"
          run "cd #{u_dir} && git add ."
          run "cd #{u_dir} && git commit -m 'Jekyll new'"
          run "cd #{u_dir} && git push origin master"
        end
      end
    end
  end
end
