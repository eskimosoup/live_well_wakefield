Rails.application.routes.draw do
  %w( 403 404 422 500 ).each do |code|
    get code, to: 'errors#show', code: code
  end

  resources :contacts, only: [:new, :create]
  resources :pages, only: :show

  resources :services, only: [], path: '' do
    resources :client_stories, path: 'client-stories'
  end

  mount Optimadmin::Engine => "/admin"
  root to: 'application#index'
end

Optimadmin::Engine.routes.draw do
  resources :pages, except: :show do
    collection do
      post 'order'
    end
    member do
      get 'edit_images'
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :contact_details, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end

  resources :client_stories, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
  resources :services, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
      get 'edit_images'
      post 'update_image_default'
      post 'update_image_fill'
      post 'update_image_fit'
    end
  end
end
