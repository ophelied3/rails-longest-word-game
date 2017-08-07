Rails.application.routes.draw do
  root to: 'numbers_and_letters#game'

  get 'score', to: 'numbers_and_letters#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
