Rails.application.routes.draw do
  #トップページ(ログイン前)
  root to: "public/homes#top"

  # ユーザー新規登録、ログイン
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者ログイン
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  # 管理者側
  namespace :admin do
    #ユーザーページ
    resources :users, only: [:index, :edit, :show, :update, :destroy]

    #イラストページ
    resources :illustrations, only: [:show, :edit, :update]

    #トップページ
    get '/' => 'homes#top'
  end


  #ユーザー側
  scope module: :public do

    #ユーザーページ
    get 'users/unsubscribe' => 'users#unsubscribe' #ユーザー退会画面
    patch 'users/withdraw' => 'users#withdraw'     #ユーザー退会処理
    resources :users, only: [:show, :edit, :update]

    #イラストページ
    resources :illustrations, only: [:index, :new, :create, :edit, :show, :update, :destroy]

    #フォローページ
    resources :follows, only: [:index]

    #フォロワーページ
    resources :followers, only: [:index]

    #いいねページ
    resources :likes, only: [:index]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
