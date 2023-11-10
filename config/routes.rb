Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  # =>は古い書き方だからrails4以降はto:で記述
  get 'home/about', to: 'homes#about', as: 'about'
  get "search", to: "searches#search"
  get 'tagsearches/search', to: 'tagsearches#search'

  # memberブロック内で定義されたルートは各ユーザーのidをURLに含んだ状態で生成される
  resources :users, only: [:index, :show, :update, :edit]  do
    resource :relationships, only: [:create, :destroy]
    get 'followings', to: 'relationships#followings', as: 'followings'
    get 'followers', to: 'relationships#followers', as: 'followers'
    member do
      get :bookmarks
    end
  end

  resources :books, only: [:index, :show, :create, :update, :destroy, :edit]  do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
  end

  resources :chats, only: [:create, :destroy, :show]
  resources :videos

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

end