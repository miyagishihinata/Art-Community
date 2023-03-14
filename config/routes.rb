Rails.application.routes.draw do
  namespace :public do
    get 'gests/show'
  end
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
    resources :illustrations, only: [:show, :edit, :update] do
      resources :comments, only: [:create, :destroy] #コメント機能
    end

    #検索ページ
    resources :searches, only: [:index, :post]

    #トップページ
    get '/' => 'homes#top'
  end


  #ユーザー側
  scope module: :public do
    # ゲストログイン
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    resources :gests, only: [:show]

    #ユーザーページ
    get 'users/unsubscribe' => 'users#unsubscribe' #ユーザー退会画面
    patch 'users/withdrawl' => 'users#withdrawl'     #ユーザー退会処理
    resources :users, only: [:show, :edit, :update] do

      resource :relationships, only: [:create, :destroy]                #フォロー機能
      get 'followings' => 'relationships#followings', as: 'followings'  #フォロー一覧
      get 'followers' => 'relationships#followers', as: 'followers'     #フォロワー一覧

      member do
        get :likes #いいね一覧
      end
    end

    #イラストページ
    resources :illustrations, only: [:index, :new, :create, :edit, :show, :update, :destroy] do
      resource :likes, only: [:create, :destroy]     #いいね機能
      resources :comments, only: [:create, :destroy] #コメント機能
    end

    #タイムライン
    resources :timelines, only: [:index]

    #検索
    resources :searches, only: [:index, :post]

    #通知
    resources :notices, only: [:index]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
