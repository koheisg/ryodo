require 'net/http'

class Github::RepositoriesController < ApplicationController
  def new
    @repository = current_user.build_github_repository;
  end

  def create
    ActiveRecord::Base.transaction do
      repository = current_user.build_github_repository(repository_params)
      repository.save
      if create_repo_with_name(repository.name)
        flash[:notice] = "レポジトリを作成しました"
        redirect_to me_edit_path
      else
        flash[:notice] = "Github連携をもう一度試してみてから、レポジトリの作成を行ってください"
        redirect_to me_edit_path
      end
    end
    binding.pry
  end

  private

    def repository_params
      params.require(:github_repository).permit(:name)
    end

    def create_repo_with_name(name)
      uri = URI.parse('https://api.github.com/user/repos')
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.path)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "token #{current_user.github_access_token.access_token}"
      req.body = {
        "name" => name
      }.to_json
      res = http.request(req)
    end
end
