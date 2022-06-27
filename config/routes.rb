Rails.application.routes.draw do
  #管理者側では、ログイン機能のみを使用する為
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
    get 'top' => 'homes#top'
    get 'search' => 'searches#search'
    resources :articles
    resources :customers, only: [:show, :edit, :update] do
      get '/post_list' => 'posts#post_list'
      get '/post_comments' => 'post_comments#index', as: 'post_comments'
    end
    resources :categories, except: [:show, :new]
    resources :posts, only: [:show, :destroy, :edit, :update] do
    resources :post_comments, only: [:destroy]
  end

  end

  #会員側では、ログイン機能と新規会員登録機能の２つのみを使用する為
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
}

# deviseに新しいアクションを設定
devise_scope :customer do
   post 'customers/guest_sign_in' => 'public/sessions#guest_sign_in'
 end

scope module: :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    get 'article/:id' => 'articles#show', as: 'article'
    get 'search' => 'searches#search'
    get 'post/hashtag/:name' => 'posts#hashtag'
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :categories, only: [:show]
    #退会画面と退会処理の設定
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    get '/mypage/:id' => 'customers#mypage', as: 'mypage'


    resources :customers, only: [:edit, :update, :index, :show] do
      resource :relationships, only:[:create, :destroy]
      get '/follows' => 'relationships#follower'
      get '/followers' => 'relationships#followed'

      get '/post_comments' => 'post_comments#index', as: 'post_comments'
      get '/favorites' => 'favorites#show', as: 'favorites'
      get '/post_list' => 'posts#post_list', as: 'post_list'

  end

  end

end