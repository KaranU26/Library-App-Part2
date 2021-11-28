Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'devise/sessions' => 'sessions#new', :as => :new_sessions
  end
  root 'books#index'
  post '/books/bookDetails' => 'books#bookDetails', :as => :bookDetails_books
  post '/books/mybooks' => 'books#mybooks', :as => :mybooks_books
  get '/books/neighborhoodbranch' => 'books#neighborbranch', :as => :neighborbranch_books
  get '/books/downtownbranch' => 'books#downtownbranch', :as => :downtownbranch_books
  get '/books/suburbsbranch' => 'books#suburbsbranch', :as => :suburbsbranch_books
  post '/books/adminaccess' => 'books#adminaccess', :as => :adminaccess_books
  post '/books/:id/edit' => 'books#edit', :as => :edit_books #edit book path
  patch 'books/:id', to: 'books#update' #edit book path
  put 'books/:id', to: 'books#update'


  post 'books/checkout', to: 'books#checkout', as: 'checkout_books'
  post 'books/return', to: 'books#return', as: 'return_books'

end
