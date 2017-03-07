class Jekyll::New < Rails::Generators::Base
  def self.run
    new.execute
  end

  def execute
    User.all.each do |user|
      if user.github_access_token && user.github_repository
        u_dir = "#{Rails.root}/tmp/user_#{user.id}"
        run "cd #{u_dir} && jekyll new ./"
        run "cd #{u_dir} && git add ."
        run "cd #{u_dir} && git commit -m 'Jekyll new'"
        run "cd #{u_dir} && git push origin master"
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
end
