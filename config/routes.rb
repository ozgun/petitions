ActionController::Routing::Routes.draw do |map|

  map.petitions 'dilekceler', :controller => 'documents', :action => "index"
  map.petition_category 'dilekceler/:category_permalink', :controller => 'documents', :action => "index"
  map.petition 'dilekceler/:id/:permalink', :controller => 'documents', :action => "show"

  map.agreements 'sozlesmeler', :controller => 'documents', :action => "index"
  map.agreement_category 'sozlesmeler/:category_permalink', :controller => 'documents', :action => "index"
  map.agreement 'sozlesmeler/:id/:permalink', :controller => 'documents', :action => "show"

  map.other_documents 'diger-yazismalar', :controller => 'documents', :action => "index"
  map.other_document_category 'diger-yazismalar/:category_permalink', :controller => 'documents', :action => "index"
  map.other_document 'diger-yazismalar/:id/:permalink', :controller => 'documents', :action => "show"

  #map.resources :documents
  map.resources :assets


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  map.resource :user_session
  map.login "login", :controller => "user_sessions", :action => "new" 
  map.logout "logout", :controller => "user_sessions", :action => "destroy" 
  map.signup "signup", :controller => "users", :action => "new" 
  map.activate "activate/:id", :controller => "activations", :action => "create", :method => :get 
  #map.my_account "hesabim", :controller => "users", :action => "show"
  map.resource :account, :controller => "users"
  map.resources :users, :collection => {:order_products => :get}
  # Aşağıdaki şifre ile ilgili route mailer'larda da kullanılıyor!!
  map.forgot_my_password "sifremi-unuttum", :controller => "reset_passwords", :action => "new"
  map.reset_my_password "sifre-degisikligi", :controller => "reset_passwords", :action => "new"
  map.resources :reset_passwords
  map.resources :user_passwords
  map.resources :pages
  map.resources :categories
  #map.blog 'blog', :controller => "posts", :action => "index"
  #map.post 'blog/yazi/:id', :controller => "posts", :action => "show"

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  map.connect "admin/", :controller => "admin/home", :action => "index" 
  map.namespace :admin do |admin|
    admin.home "/home", :controller => "home", :action => "index"
    admin.resources :users, :member => {:suspend => :put, :unsuspend => :put}
    admin.resources :assets
    admin.resources :pages, :member => {:preview => :get}
    admin.resources :categories
    admin.resources :documents do |documents|
      documents.resources :samples
    end
  end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"
  #map.root :controller => "documents"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  #map.connect '*path', :controller => "pages", :action => "show"
end
