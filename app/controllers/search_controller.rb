class SearchController < ApplicationController
  def index
  end

  def create
    @query = params[:query]
    user_token = session[:search_user_token]
    last_query = SearchQuery.where(user_token: user_token).order(created_at: :desc).first

    if last_query.nil? || last_query.query_text != @query
      SearchQuery.create(user_token: user_token, query_text: @query)
    end

    head :ok
  end

  def analytics
    user_token = session[:search_user_token]
    @searches = SearchQuery.where(user_token: user_token).order(created_at: :desc)
  end
end
