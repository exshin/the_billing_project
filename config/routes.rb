# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'pages/root'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#root'

  namespace :organizations do
    get :search
  end

  namespace :tickets do
    get :search
  end

  namespace :users do
    get :search
  end
end
