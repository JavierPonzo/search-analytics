class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 200 }
  validates :content, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :title, uniqueness: { case_sensitive: false }
end
