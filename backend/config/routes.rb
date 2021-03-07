Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :time_blocks
  get 'token', to: 'channels#get_token'
  get 'active_channels', to: 'channels#active'
  post 'super_secret_muk', to: 'id_mappings#create'
  get 'google_uid', to: 'id_mappings#google_uid'
  get 'agora_uid', to: 'id_mappings#agora_uid'
end
