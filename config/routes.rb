Rails.application.routes.draw do
  get 'new', to: "np_cs#index"
  get 'wakeup', to: 'np_cs#wakeup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
