Rails3Extjs4::Application.routes.draw do

  root :to => "index#index"

  match 'drivers/index_data' => 'drivers#index_data'
  match 'drivers/edit_data' => 'drivers#edit_data'
  resources :drivers

  match 'gundams/index_data' => 'gundams#index_data'
  match 'gundams/edit_data' => 'gundams#edit_data'
  match 'gundams/send_info' => 'gundams#send_info'
  resources :gundams

  match 'periods/index_data' => 'periods#index_data'
  match 'periods/all_data' => 'periods#all_data'
  match 'periods/edit_data' => 'periods#edit_data'
  resources :periods

  match 'types/index_data' => 'types#index_data'
  match 'types/all_data' => 'types#all_data'
  match 'types/edit_data' => 'types#edit_data'
  resources :types

  match 'users/index_data' => 'users#index_data'
  match 'users/edit_data' => 'users#edit_data'
  resources :users

  match 'dimensions/index_data' => 'dimensions#index_data'
  match 'dimensions/all_data' => 'dimensions#all_data'
  match 'dimensions/edit_data' => 'dimensions#edit_data'
  resources :dimensions

end
