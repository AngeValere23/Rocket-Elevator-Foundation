Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  mount RailsAdmin::Engine => '/backoffice', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#index'

  post '/lead' => 'pages#post_lead'

  get '/lead(.:id)' => 'pages#download_lead'

  get '/residential' => 'pages#residential'

  get '/corporate' => 'pages#corporate'

  get '/quote' => 'pages#quote'

  post '/quote' => 'pages#post_quote', as: 'post_quote'

  post '/starwars' => 'pages#star_wars'

  get "pages/index"
end
