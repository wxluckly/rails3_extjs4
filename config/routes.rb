Rails3Extjs4::Application.routes.draw do
  root :to => "index#index"

  devise_for :users

  resources :search_suggestions

  resources :gundams do
    resources :gundam_photos, :only => [:new, :create, :show]
  end

  resources :gundam_photos, :only => [:index, :avatar] do 
    get 'avatar', :on => :member
    post 'crop', :on => :member
  end

  get '/search' => "search#index"

  resources :versions do
    member do
      put "merge"
    end
  end

  namespace "admin" do
    root :to => "index#index"

    resources :drivers do 
      collection do
        get 'index_data'
        get 'edit_data'
      end
    end

    resources :gundams do 
      collection do
        get 'index_data'
        get 'edit_data'
        get 'send_info'
      end
    end

    resources :gundam_photos do 
      collection do
        get 'index_data'
        get 'edit_data'
        post 'set_verified'
      end
    end

    resources :periods do 
      collection do
        get 'index_data'
        get 'all_data'
        get 'edit_data'
      end
    end

    resources :usages do 
      collection do
        get 'index_data'
        get 'all_data'
        get 'edit_data'
      end
    end

    resources :users do 
      collection do
        get 'index_data'
        get 'all_data'
        get 'edit_data'
      end
    end

    resources :dimensions do 
      collection do
        get 'index_data'
        get 'all_data'
        get 'edit_data'
      end
    end

    match "/processes" => ProcessesApp
  end

end
