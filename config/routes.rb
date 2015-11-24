Rails.application.routes.draw do
  devise_for :user
  devise_scope :user do
    resources :users
    resources :todo_lists do
      resources :todos, only: [:index, :create, :update, :destroy] do # , :path => ''
        collection do
          put :update_many
          delete :destroy_many
        end
      end
      member do
        get :public_show
      end
    end
  end
  authenticated :user do
    root to: 'todo_lists#index', as: :authenticated_root
  end
  unauthenticated do
    root to: 'visitors#index', as: :unauthenticated_root
  end
  root to: 'visitors#index'
end
