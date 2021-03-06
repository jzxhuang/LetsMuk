Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :time_blocks
  get 'token', to: 'channels#get_token'
  get 'active_channels', to: 'channels#active'
end
