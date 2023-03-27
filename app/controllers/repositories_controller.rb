require "services/github/connector"

class RepositoriesController < ApplicationController
  def index
  end

  def search
    response = Services::Github::Connector.search_repositories(query_params)
    if response[:status_code] == 200
      repositories = response["items"]
      total_count = response["total_count"]
      page = 1
      render json: { repositories: repositories, fetched_count: repositories.count, total: total_count, page: page }
    else
      render json: { error: response[:message] }, status: response[:status_code]
    end
  end

  private
  def query_params
    params.permit(:query).fetch(:query, nil)
  end
end
