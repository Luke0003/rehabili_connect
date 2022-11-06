Rails.application.routes.draw do

  # deviseのURLを変更
  devise_scope :client do
    root "public/sessions#new"
    get  "/clients/sign_in" => redirect("/")
  end

  devise_for :clients, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  devise_for :therapists, skip: [:passwords], controllers: {
    registrations: 'therapist/registrations',
    sessions: 'therapist/sessions'
  }

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  scope module: :public do
    # root "sessions#new"
    get 'clients/my_page' => 'clients#show'
    get 'clients/information/edit' => 'clients#edit'
    patch 'clients/information' => 'clients#update'
    resources :client_records, only: [:index, :show, :edit, :new, :create, :update]
  end

  namespace :therapist do
    root 'homes#top'
    get 'my_page' => 'therapists#show'
    get 'information/edit' => 'therapists#edit'
    patch 'information' => 'therapists#update'
    resources :menus
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    resources :clients, only: [:show] do
      resources :client_records, only: [:index, :show]
      resources :client_menus, only: [:index, :new, :edit, :create, :update, :destroy]
    end
  end

  namespace :admin do
    root 'homes#top'
    resources :clients, only: [:index, :show, :edit, :update]
    resources :therapists, only: [:show, :edit, :update]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
