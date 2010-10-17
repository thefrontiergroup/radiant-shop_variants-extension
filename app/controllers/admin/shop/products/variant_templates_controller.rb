class Admin::Shop::Products::VariantTemplatesController < Admin::ResourceController
  
  model_class ShopVariant
  
  def update
    error = 'Could not attach all Variants to Product.'
    
    @shop_product = ShopProduct.find(params[:product_id])
    
    if @shop_product.apply_variant_template(@shop_variant)
      respond_to do |format|
        format.html {
          redirect_to [ :edit_admin, @shop_product ]
        }
      end
    else
      respond_to do |format|
        format.html { 
          flash[:error] = error
          redirect_to [ :edit_admin, @shop_product ]
        }
      end
    end
    
  end
  
end