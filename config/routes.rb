require "sidekiq/web"

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == ENV.fetch("SIDEKIQ_USERNAME", "admin") && password == ENV.fetch("SIDEKIQ_PASSWORD", "password")
end

Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?

  if Rails.env.development? || Rails.env.production?
    Sidekiq::Web.use ActionDispatch::Cookies
    Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: ENV.fetch("SIDEKIQ_SESSION_KEY", "_your_app_session")
    mount Sidekiq::Web => "/sidekiq"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
