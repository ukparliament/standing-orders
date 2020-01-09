Rails.application.routes.draw do
  
  get '/' =>'home#index', as: :home
  
  get 'adoption-dates' => 'adoption_date#index', as: :adoption_date_list
  
  get 'adoption-dates/:adoption_date' => 'adoption_date#show', as: :adoption_date_show
  
  get 'standing-order-fragments' => 'standing_order_fragment#index', as: :standing_order_fragment_list
  
  get 'standing-order-fragments/:standing_order_fragment' => 'standing_order_fragment#show', as: :standing_order_fragment_show
  
  get 'sankey' => 'sankey#show', as: :sankey_show

end
