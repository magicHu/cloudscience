Cloudscience::Application.routes.draw do
  resources :ideas do
    collection do
      match 'all'
    end
    member do
      match 'open'
      match 'close'
    end
  end

  resources :folders do
    member do
      match 'add_paper'
      match 'remove_paper'
    end
    collection do
      match 'refresh'
    end
  end

  get "admin/index"

  controller :library do
    get 'library' => :index
    get 'library/search', :as => :search_library
    get 'publications' => :publications, :as => :publications
  end
  match 'library/paper/:id' => 'library#paper', :as => :paper_in_library
  match 'library/paper/:id/update' => 'library#update_paper', :as => :update_paper

  resources :tags do
  end

  match 'add_to_library/:id' => 'papers#add_to_library', :as => :add_to_library
  match 'remove_from_library/:id' => 'papers#remove_from_library', :as => :remove_from_library
  match 'add_to_publish/:id' => 'papers#add_to_publish', :as => :add_to_publish
  resources :papers do
    collection do
      match 'search'
    end
    member do
      match 'publish'
      match 'add_to_folder'
      match 'remove_from_folder'
    end
  end

  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'} do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    get 'logout' => 'custom_devise/sessions#destroy', :as => :destroy_user_session
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'papers#index'

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
match ':controller(/:action(/:id(.:format)))'
end
