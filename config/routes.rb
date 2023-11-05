Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  get "search" => "searches#search"
  resources :users, only: [:index, :show, :update, :edit]  do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books, only: [:index, :show, :create, :update, :destroy, :edit]  do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :chats, only: [:create, :destroy, :show]
  get 'tagsearches/search', to: 'tagsearches#search'

end