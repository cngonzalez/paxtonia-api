Rails.application.routes.draw do
  resources :games
  resources :npcs do 
    resources :responses, only: [:new]
  end
  
  get 'new', to: "np_cs#index"
  get 'wakeup', to: 'np_cs#wakeup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
