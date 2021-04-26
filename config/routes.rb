Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/s/:slug', to: 'home#redirect_main_url'
  get '/admin/s/:slug', to: 'home#link_details'
  resources :home do 
  	collection do 
  		post 'generate_urls'
  		get 'make_expire'
  	end
  end
end
