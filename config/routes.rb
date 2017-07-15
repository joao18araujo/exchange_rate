Rails.application.routes.draw do
  root 'brl_exchange_rates#index'
  get '/brl_exchange_rates' => 'brl_exchange_rates#index'

end
