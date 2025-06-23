# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :products
      resources :orders do
        resources :order_items, only: [ :create, :update, :destroy ]
      end
      resources :order_items, only: [ :index, :show, :create, :destroy ]
    end
  end
end
