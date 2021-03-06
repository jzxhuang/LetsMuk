Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :time_blocks
  get 'token', to: 'time_blocks#get_token'
end
