require "rails_helper"

RSpec.describe Article, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:title).is_at_most(200) }
    it { should validate_length_of(:content).is_at_most(1000) }
  end

  describe "creation" do
    it "creates a valid article" do
      article = build(:article)
      expect(article).to be_valid
    end

    it "is invalid without title" do
      article = build(:article, title: nil)
      expect(article).not_to be_valid
    end

    it "is invalid without content" do
      article = build(:article, content: nil)
      expect(article).not_to be_valid
    end
  end

  describe "searching" do
    let!(:article1) { create(:article, title: "Ruby on Rails", content: "Web framework") }
    let!(:article2) { create(:article, title: "JavaScript", content: "Programming language") }

    it "finds articles by title" do
      results = Article.where("title ILIKE ?", "%Ruby%")
      expect(results).to include(article1)
      expect(results).not_to include(article2)
    end
  end
end
