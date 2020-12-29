Rails.application.routes.draw do
  get '/search', to: 'books#search'
  get '/amazon/:isbn', to: 'books#show'
end
