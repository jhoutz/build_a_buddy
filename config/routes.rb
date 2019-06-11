Rails.application.routes.draw do
  resources :products, only: %i[index show]
  get 'item_var_recommendations' => 'products#item_var_recommendations', as: :item_var_recommendations, defaults: { format: 'json' }

  root to: 'products#index'
end
