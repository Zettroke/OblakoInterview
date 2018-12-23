Rails.application.routes.draw do
  get 'todos/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :todos

  root 'todos#index'
end
