require "rails_helper"

RSpec.describe SearchController, type: :controller do
  describe "GET #index" do
    let!(:article1) { create(:article, title: "Ruby Basics", content: "Learn Ruby") }
    let!(:article2) { create(:article, title: "Rails Guide", content: "Build apps") }

    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns all articles when no search query" do
      get :index
      expect(assigns(:articles)).to match_array([ article1, article2 ])
    end

    it "shows all articles regardless of search query" do
      get :index, params: { q: "Ruby" }
      expect(assigns(:articles)).to include(article1, article2)
    end
  end

  describe "POST #create" do
    before do
      session[:search_user_token] = "test_user_123"
    end

    it "creates a search query record" do
      expect {
        post :create, params: { query: "ruby programming" }
      }.to change(SearchQuery, :count).by(1)
    end

    it "returns success response" do
      post :create, params: { query: "ruby" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #analytics" do
    before do
      session[:search_user_token] = "test_user_123"
      create(:search_query, query_text: "ruby", user_token: "test_user_123")
      create(:search_query, query_text: "rails", user_token: "test_user_123")
    end

    it "returns a successful response" do
      get :analytics
      expect(response).to be_successful
    end

    it "assigns user searches" do
      get :analytics
      expect(assigns(:searches).count).to eq(2)
    end
  end

  describe "POST #create_article" do
    let(:valid_params) do
      { article: { title: "New Question", content: "New Answer" } }
    end

    it "creates a new article with valid params" do
      expect {
        post :create_article, params: valid_params, format: :json
      }.to change(Article, :count).by(1)
    end

    it "returns success response for valid article" do
      post :create_article, params: valid_params, format: :json
      json_response = JSON.parse(response.body)
      expect(json_response["success"]).to be true
      expect(json_response["message"]).to eq("Question added successfully!")
    end

    it "returns error response for invalid article" do
      invalid_params = { article: { title: "", content: "" } }
      post :create_article, params: invalid_params, format: :json
      json_response = JSON.parse(response.body)
      expect(json_response["success"]).to be false
    end
  end
end
