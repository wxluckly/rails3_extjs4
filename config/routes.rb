Rails3Extjs4::Application.routes.draw do


  # root :to => "index#index"

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

    resources :types do 
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

  end
  devise_for :users

end
