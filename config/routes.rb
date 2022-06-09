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

scope module: :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    # resources :articles, only: [:show]
    get 'article/:id' => 'articles#show', as: 'article'
    resources :posts

    get 'mypage' => 'customers#mypage'
    #退会画面と退会処理の設定
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch '/customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'

    resources :customers, only: [:edit, :update]

  end

end