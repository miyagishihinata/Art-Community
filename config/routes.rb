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
    resources :users, only: [:index, :edit, :show, :update]

    #イラストページ
    resources :illustrations, only: [:show, :edit, :update]

    #トップページ
    get '/' => 'homes#top'
  end


  #ユーザー側
  scope module: :public do
    #ユーザーページ
    get 'users/unsubscribe' => 'customers#unsubscribe'
    patch 'users/withdraw' => 'customers#withdraw'
    resources :users, only: [:show, :edit, :update]

    #イラストページ
    resources :illustrations, only: [:new, :create, :index, :show, :update, :update]

    #トップページ
    get '/' => 'homes#top'
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
