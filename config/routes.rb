Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :project

  get '/projects', to: 'project#index'
  post '/todos', to: 'project#create_todo'
  patch '/projects', to: 'project#update'
end
