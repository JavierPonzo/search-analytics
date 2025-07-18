class SearchController < ApplicationController
  def index
    @articles = Article.all
  end


  def create
    @query = params[:query]
    user_token = session[:search_user_token]
    last_query = SearchQuery.where(user_token: user_token).order(created_at: :desc).first

    # If no last query, or time window expired, always create a new record
    if last_query.nil? || (Time.now - last_query.created_at > 60)
      SearchQuery.create(user_token: user_token, query_text: @query)
    else
      # If the new query does not include the previous, treat as a new search
      unless @query.downcase.include?(last_query.query_text.to_s.downcase) || last_query.query_text.to_s.downcase.include?(@query.downcase)
        SearchQuery.create(user_token: user_token, query_text: @query)
      else
        # Otherwise, update last query
        last_query.update(query_text: @query)
      end
    end

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

  def create_article
    @article = Article.new(article_params)

    if @article.save
      render json: {
        success: true,
        message: "Question added successfully!",
        article: {
          title: @article.title,
          content: @article.content
        }
      }
    else
      render json: {
        success: false,
        message: "Error: #{@article.errors.full_messages.join(', ')}"
      }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
