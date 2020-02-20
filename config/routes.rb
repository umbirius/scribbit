Rails.application.routes.draw do
  # devise_for :installs
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  root to:'application#welcome'
  resources :projects do 
    resources :characters
    resources :setts
    resources :scenes
  end 

  resources :characters, :scenes, :setts
  # only new with drop down of project
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
