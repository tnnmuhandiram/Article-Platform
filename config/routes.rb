Rails.application.routes.draw do

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #selected type routes 
  get '/select-type', to: 'home#select_type'
  post '/home/import/sources', to:'home#import_sources'
  post '/home/import/everything', to:'home#import_everything'
  post '/home/import/top-headline', to:'home#import_headline'

  # article routes 
  get 'article/show'
  get 'article/create'

  #articles api routes 
  namespace :api do
    namespace :v1 do
     resources :articles
    end
  end

end
  