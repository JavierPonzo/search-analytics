require "rails_helper"

RSpec.describe SearchQuery, type: :model do
  describe "validations" do
    it { should validate_presence_of(:query_text) }
    it { should validate_presence_of(:user_token) }
  end

  describe "creation" do
    it "creates a valid search query" do
      search_query = build(:search_query)
      expect(search_query).to be_valid
    end

    it "is invalid without query_text" do
      search_query = build(:search_query, query_text: nil)
      expect(search_query).not_to be_valid
    end

    it "is invalid without user_token" do
      search_query = build(:search_query, user_token: nil)
      expect(search_query).not_to be_valid
    end
  end

  describe "analytics" do
    let(:user_token) { "test_user_123" }

    before do
      create(:search_query, query_text: "ruby", user_token: user_token)
      create(:search_query, query_text: "rails", user_token: user_token)
      create(:search_query, query_text: "ruby", user_token: user_token)
    end

    it "counts total searches for a user" do
      count = SearchQuery.where(user_token: user_token).count
      expect(count).to eq(3)
    end

    it "groups searches by query" do
      grouped = SearchQuery.where(user_token: user_token).group(:query_text).count
      expect(grouped["ruby"]).to eq(2)
      expect(grouped["rails"]).to eq(1)
    end
  end
end
