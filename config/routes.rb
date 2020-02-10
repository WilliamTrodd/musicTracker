Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :albums
    
  root 'welcome#index'
end