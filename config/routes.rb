Rails.application.routes.draw do
  root 'brl_exchange_rates#index'

  get '/brl_exchange_rates' => 'brl_exchange_rates#index'
  post '/process_json' => 'brl_exchange_rates#process_json'
  get '/statics' => 'statics#index'

end
