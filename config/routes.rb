require "sidekiq/web"

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"

  post "/images/upload", to: "uploads#image"

  post "/graphql", to: "graphql#execute"

  get "/simple", to: "simples#simple"
end
