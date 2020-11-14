Rails.application.routes.draw do
  
  get '/' =>'home#index', as: :home
  
  get 'adoptions' => 'adoption#index', as: :adoption_list
  get 'adoptions/:adoption' => 'adoption#show', as: :adoption_show
  
  get 'fragments' => 'fragment#index', as: :fragment_list
  get 'fragments/:fragment' => 'fragment#show', as: :fragment_show
  
  
  
  
  
  
  
  
  
  get 'adoption-dates' => 'adoption_date#index', as: :adoption_date_list
  
  get 'adoption-dates/:adoption_date' => 'adoption_date#show', as: :adoption_date_show
  
  get 'standing-order-fragments' => 'standing_order_fragment#index', as: :standing_order_fragment_list
  
  get 'standing-order-fragments/:standing_order_fragment' => 'standing_order_fragment#show', as: :standing_order_fragment_show
  
  get 'sankey' => 'sankey#show', as: :sankey_show
  
  get 'meta' => 'meta#index', as: :meta_list
  
  get 'meta/schema' => 'meta#schema', as: :meta_schema
  
  get 'meta/dump' => 'meta#dump', as: :meta_dump

end
