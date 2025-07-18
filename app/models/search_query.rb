class SearchQuery < ApplicationRecord
  validates :query_text, presence: true
  validates :user_token, presence: true
end
