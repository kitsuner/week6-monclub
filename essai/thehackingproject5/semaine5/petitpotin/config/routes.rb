Rails.application.routes.draw do
  get '/', to: 'static#index'
  post '/', to: 'static#index_post'
  get '/team', to: 'static#team'
  get '/contact', to: 'static#contact'
  get '/:id', to: 'static#user'
  post '/:id', to: 'static#user_post'
  get '/gossip/:id', to: 'static#gossip'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
