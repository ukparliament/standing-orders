Rails.application.routes.draw do
  
  get '/' =>'home#index', as: :home
  
  get 'adoptions' => 'adoption#index', as: :adoption_list
  get 'adoptions/:adoption' => 'adoption#show', as: :adoption_show
  get 'adoptions/:adoption/orders' => 'adoption#order', as: :adoption_order
  get 'adoptions/:adoption/fragments' => 'adoption#fragment', as: :adoption_fragment
  
  get 'fragments' => 'fragment#index', as: :fragment_list
  get 'fragments/:fragment' => 'fragment#show', as: :fragment_show
  
  get 'orders' => 'order#index', as: :order_list
  get 'orders/:order' => 'order#show', as: :order_show
  
  get 'order-versions' => 'order_version#index', as: :order_version_list
  get 'order-versions/:order_version' => 'order_version#show', as: :order_version_show
  
  get 'fragment-versions' => 'fragment_version#index', as: :fragment_version_list
  get 'fragment-versions/:fragment_version' => 'fragment_version#show', as: :fragment_version_show
  
  
  
  
  
  
  
  
  
  get 'adoption-dates' => 'adoption_date#index', as: :adoption_date_list
  
  get 'adoption-dates/:adoption_date' => 'adoption_date#show', as: :adoption_date_show
  
  get 'standing-order-fragments' => 'standing_order_fragment#index', as: :standing_order_fragment_list
  
  get 'standing-order-fragments/:standing_order_fragment' => 'standing_order_fragment#show', as: :standing_order_fragment_show
  
  get 'sankey' => 'sankey#show', as: :sankey_show
  
  get 'meta' => 'meta#index', as: :meta_list
  
  get 'meta/schema' => 'meta#schema', as: :meta_schema
  
  get 'meta/dump' => 'meta#dump', as: :meta_dump

end
