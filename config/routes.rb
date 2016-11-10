Rails.application.routes.draw do
  get 'newgame', to: 'games#new' 
  post '/games/:id/talk', to: 'games#talk'
  get 'wakeup', to: 'np_cs#wakeup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
