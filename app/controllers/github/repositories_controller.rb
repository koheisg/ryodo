require 'net/http'

class Github::RepositoriesController < ApplicationController
  def new
    @repository = current_user.github_repository.build
  end

  def create
    repository = current_user.github_repository.build(repository_params)
    repository.save
    url = "https://api.github.com/user/repos"
    http = Net::HTTP.new
    res = http.post(URI.parse(url), {
      name: repository.name
    },
    "Authorization" => "token #{current_user.github_access_token.access_token}")
    binding.pry
  end

  private

    def repository_params
      params.require(:github_repository).permit(:name)
    end
end
