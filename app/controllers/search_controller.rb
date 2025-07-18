class SearchController < ApplicationController
  before_action :ensure_user_token

  def index
    @articles = Article.all
  end

  def create
    @query = params[:query].to_s.strip
    return head :ok if @query.blank?

    user_token = session[:search_user_token]
    SearchQuery.create(user_token: user_token, query_text: @query)

    head :ok
  end

  def analytics
    user_token = session[:search_user_token]
    @searches = SearchQuery.where(user_token: user_token).order(created_at: :desc)
  end

  def reset_analytics
    user_token = session[:search_user_token]
    SearchQuery.where(user_token: user_token).delete_all
    redirect_to analytics_path, notice: "Your search analytics were cleared."
  end

  private

  def ensure_user_token
    session[:search_user_token] ||= SecureRandom.hex(16)
  end
end
