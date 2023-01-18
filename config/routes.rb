Rails.application.routes.draw do

  devise_for :clients, skip: [:registrations], controllers: {
    sessions: 'public/sessions',
    invitations: 'public/invitations',
    passwords: 'public/passwords'
  }

  devise_for :therapist, skip: [:registrations], controllers: {
    sessions: 'therapist/sessions',
    invitations: 'therapist/invitations',
    passwords: 'therapist/passwords'
  }

  devise_for :admin, skip: [:registrations, :passwords, :invitations], controllers: {
    sessions: 'admin/sessions',
  }

  namespace 'api' do
    namespace 'v1' do
      resources :prefectures, only: [:index]
    end
  end

  scope module: :public do
    root 'homes#top'
    get 'clients/my_page' => 'clients#show'
    get 'clients/information/edit' => 'clients#edit'
    patch 'clients/information' => 'clients#update'
    resources :client_records, only: [:show, :create, :update]
    resources :chats, only: [:show, :create]
    resources :menus, only: [:show]
    resources :rehabili_times, only: [:new, :create]
  end

  namespace :therapist do
    root 'homes#top'
    get 'my_page' => 'therapists#show'
    get 'information/edit' => 'therapists#edit'
    patch 'information' => 'therapists#update'
    resources :menus
    get 'serarch' => 'menus#search'
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    resources :clients, only: [:show, :edit, :update] do
      resources :client_records, only: [:index, :show]
      resources :client_menus, only: [:index, :edit, :create, :update, :destroy]
      get 'serarch' => 'client_menus#search'
      resources :chats, only: [:show, :create]
    end
  end

  namespace :admin do
    root 'homes#top'
    resources :clients, only: [:index, :show, :edit, :update]
    resources :therapists, only: [:show, :edit, :update]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
