Rcomix::Application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create'
  get '/comics' => 'comics#index'
  get '/comics/:feed_id/strip/:strip_id' => 'comics#strip'

  get '/settings' => 'settings#index'
  post '/settings' => 'settings#update'

  root :to => 'comics#index'
end
