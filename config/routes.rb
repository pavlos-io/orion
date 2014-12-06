Rails.application.routes.draw do

  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  # oauth callback failure route
  get 'users/auth/failure' do
    flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
    redirect '/'
  end

  # custom resources
  resources :giveaways

  # get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
end
