Cloudarena::Application.routes.draw do

	devise_for :users, :path_names => { :sign_in => "giris-yap", :sign_up => "uye-ol", :sign_out => "cikis"}, :controllers => { :omniauth_callbacks => "omniauth_callbacks"}

  #get "/author", :to => proc {|env| [200, {}, ["@author = Mehmet Emin INAC"]]}

  root :to => "home#index"

  get "logged_out" => "home#logged_out", :path => "seni-ozluycez"

  resources :accounting_records, :path => "muhasebe-defteri" do
    member do
      get :payed, :path => "odendi"
      get :publish_on_facebook, :path => "facebookta-paylas"
    end
    collection do
      get :new_credit, :path => "alacak-ekle"
      get :new_debt, :path => "borc-ekle"
    end
  end

  resources :contacts, :path => "kisiler" do
  end

  resources :profiles, :path => "/" do
    collection do
      get :my_profile, :path => "profilim"
    end
  end

end
