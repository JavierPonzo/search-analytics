FactoryBot.define do
  factory :search_query do
    query_text { "programming" }
    user_token { "test_token_123" }
  end
end
