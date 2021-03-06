Rails.application.routes.draw do
  
  get '/' =>'home#index', as: :home
  
  get 'houses' => 'house#index', as: :house_list
  get 'houses/:house' => 'house#show', as: :house_show
  get 'houses/:house/business-extents' => 'house#business_extent_index', as: :house_business_extent_list
  get 'houses/:house/business-extents/:business_extent' => 'house#business_extent_show', as: :house_business_extent_show
  get 'houses/:house/business-extents/:business_extent/revision-sets' => 'house#business_extent_revision_set_list', as: :house_business_extent_revision_set_list
  
  get 'business-extents' => 'business_extent#index', as: :business_extent_list
  get 'business-extents/:business_extent' => 'business_extent#show', as: :business_extent_show
  get 'business-extents/:business_extent/houses' => 'business_extent#house_index', as: :business_extent_house_list
  
  get 'revision-sets' => 'revision_set#index', as: :revision_set_list
  get 'revision-sets/:revision_set' => 'revision_set#show', as: :revision_set_show
  get 'revision-sets/:revision_set/orders' => 'revision_set#order', as: :revision_set_order
  get 'revision-sets/:revision_set/fragments' => 'revision_set#fragment', as: :revision_set_fragment
  
  get 'fragments' => 'fragment#index', as: :fragment_list
  get 'fragments/:fragment' => 'fragment#show', as: :fragment_show
  get 'fragments/:fragment/permalink' => 'fragment#redirect', as: :fragment_redirect
  get 'fragments/:fragment/versions' => 'fragment#versions', as: :fragment_versions
  get 'fragments/:fragment/versions/revisions' => 'fragment#revisions', as: :fragment_revisions
  get 'fragments/:fragment/versions/revisions/minor' => 'fragment#minor_revisions', as: :fragment_minor_revisions
  get 'fragments/:fragment/versions/revisions/major' => 'fragment#major_revisions', as: :fragment_major_revisions
  
  get 'orders' => 'order#index', as: :order_list
  get 'orders/:order' => 'order#show', as: :order_show
  get 'orders/:order/permalink' => 'order#redirect', as: :order_redirect
  get 'orders/:order/versions' => 'order#versions', as: :order_versions
  get 'orders/:order/versions/revisions' => 'order#revisions', as: :order_revisions
  get 'orders/:order/versions/revisions/minor' => 'order#minor_revisions', as: :order_minor_revisions
  get 'orders/:order/versions/revisions/major' => 'order#major_revisions', as: :order_major_revisions
  
  get 'order-versions' => 'order_version#index', as: :order_version_list
  get 'order-versions/:order_version' => 'order_version#show', as: :order_version_show
  
  get 'fragment-versions' => 'fragment_version#index', as: :fragment_version_list
  get 'fragment-versions/:fragment_version' => 'fragment_version#show', as: :fragment_version_show
  
  get 'revisions' => 'revision#index', as: :revision_list
  get 'revisions/:revision' => 'revision#show', as: :revision_show
  
  get 'meta' => 'meta#index', as: :meta_list
  get 'meta/schema' => 'meta#schema', as: :meta_schema
  
  get 'sankey' => 'sankey#show', as: :sankey_show
end
