class Github::Repository::Clone < Rails::Generators::Base
  def self.run
    new.execute
  end

  def execute
    User.all.each do |user|
      if user.github_access_token && user.github_repository
        u_dir = "#{Rails.root}/tmp/user_#{user.id}/"
        git clone: "git@github.com:#{user.username}/#{user.github_repository.name}.git #{u_dir}"
      end
    end
  end
end
