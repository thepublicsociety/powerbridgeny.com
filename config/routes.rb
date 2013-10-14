Template::Application.routes.draw do

  scope 'administration' do
    resources :contents
    resources :questions do
      post :sort, on: :collection
      resources :answers
    end
    resources :answers
    resources :about_sections
    resources :posts
    resources :subscriptions
    resources :judges
    resources :attachments
    resources :mentors
    resources :contacts
    resources :events
  end
  
  match "/administration" => "pages#admin", :as => "admin" #"user_root"
  match "/auth/:provider/callback" => "pages#external_auth"
  #match "/home" => "pages#index", :as => "website"
  match "/contact" => "pages#contact"
  match '/mail' => 'pages#send_mail', :as => :email, :via => :post
  match '/faq' => "pages#faq"
  match "/accept-answer" => "pages#accept_answer"
  match '/about' => "pages#about"
  match '/news' => "pages#news"
  match '/article/:id' => "pages#article"
  match '/calendar' => "pages#calendar"
  match '/application' => "pages#application"
  match '/dashboard' => "pages#dashboard"
  
  get "pages/index"
  get "pages/administration"

  devise_for :users, :path => 'administration/account', :controllers => {:registrations => "registrations", :sessions => "sessions", :passwords => "passwords"}
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "logout", :to => "devise/sessions#destroy"
    get "register", :to => "registrations#new"
    get "/administration/account/settings" => "registrations#edit"
  end
  resources :users
  #authenticated :user, lambda {|u| u.admin == true} do
  #  root :to => "pages#admin", :as => :admin_root
  #  match "/home" => "pages#index", :as => "website"
  #end
  
  root :to => "pages#index"

end
