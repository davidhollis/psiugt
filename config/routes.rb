Rails.application.routes.draw do

  resources :posts, only: %i(index show)

  #Casein routes
  namespace :casein do
    resources :menu_items do
      post :move, on: :member
    end
    resources :posts
    resources :pages do
      get :titles, on: :collection, format: :json
      post :image_upload, on: :collection, format: :json
    end
    resources :members do
      post :render_chart, on: :collection
    end
    resources :initiation_classes
  end

  get '*path', controller: :pages, action: :show
  root controller: :posts, action: :index
end
