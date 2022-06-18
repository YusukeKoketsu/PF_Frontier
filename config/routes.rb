Rails.application.routes.draw do
  #管理者側では、ログイン機能のみを使用する為
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
    get 'top' => 'homes#top'
    resources :articles
    resources :customers, only: [:show, :edit, :update]
    resources :categories, except: [:show, :new]

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
    get 'mypage/:full_name' => 'customers#mypage', as: 'mypage'
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

    resources :customers, only: [:edit, :update, :index, :show] do
      get 'post_comments' => 'post_comments#index'
      get 'posts' => 'posts#post_list'
      resource :relationships, only:[:create, :destroy]
      get 'follows' => 'relationships#follower'
      get 'followers' => 'relationships#followed'

  end

  end

end