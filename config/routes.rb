Rails.application.routes.draw do
  #管理者側では、ログイン機能のみを使用する為
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  #会員側では、ログイン機能と新規会員登録機能の２つのみを使用する為
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
}
end
