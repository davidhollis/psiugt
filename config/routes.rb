Rails.application.routes.draw do

	#Casein routes
	namespace :casein do
		resources :menu_items do
      post :move, on: :member
    end
		resources :posts
		resources :pages do
      get :titles, on: :collection, format: :json
    end
		resources :members
		resources :initiation_classes
	end

  get '*path', controller: :pages, action: :show
  root controller: :pages, action: :show
end
