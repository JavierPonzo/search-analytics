Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  post "search", to: "search#create"
  get "analytics", to: "search#analytics"
  post "articles", to: "search#create_article"
  root "search#index"
  delete "analytics/reset", to: "search#reset_analytics", as: :reset_analytics
end
