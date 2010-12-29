ActionController::Routing::Routes.draw do |map|
  
  map.namespace :admin do |admin|
    admin.namespace :shop, :member => { :remove => :get } do |shop| 
       
      shop.resources :products, :except => :new, :collection => { :sort => :put } do |product|
        product.resources :variants,          :controller => 'products/variants',           :only => [ :create, :destroy]
        product.resources :variant_templates, :controller => 'products/variant_templates',  :only => [ :update ]
      end
      shop.resources :variants
      shop.resources :product_variants, :controller => 'products'
      
    end
  end

end