require "sidekiq/web"

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Rails.application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq" if Settings.show_sidekiq_web?

  post "/images/upload", to: "uploads#image"

  post "/graphql", to: "graphql#execute"
end
