Rails.application.routes.draw do
  resources :people
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #get 'people/search', to: 'people#search', as: 'search_people'
  get 'search', to: 'people#search', as: 'search_people'


  # a route for the search action 
  resources :people do
    collection do
      post 'search'
    end
  end
  
  get 'today', to: 'people#tbirthdays'

  # Defines the root path route ("/")
  root "people#index"
end
