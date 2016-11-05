Rails.application.routes.draw do
  resources :npcs
  get 'wakeup', to: 'np_cs#wakeup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
