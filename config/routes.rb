Rails.application.routes.draw do
  match '/projects', to: 'project#index', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
