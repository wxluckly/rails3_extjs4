Rails3Extjs4::Application.routes.draw do
  root :to => "index#index"

  devise_for :users

  resources :gundams do
    resources :gundam_photos, :only => [:new, :create, :show]
  end

  resources :gundam_photos, :only => [:index]

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
