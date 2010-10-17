class Admin::Shop::Products::VariantsController < Admin::ResourceController
  
  model_class ShopProductVariant
  
  before_filter :find_product
    
  def create
    notice  = 'Successfully created variant.'
    error   = 'Could not create variant.'
    
    begin
      @shop_product_variant.attributes = params[:shop_product_variant]
      @shop_product_variant.save!
      
      respond_to do |format|
        format.html {
          redirect_to edit_admin_shop_product_path(@shop_product)
        }
        format.js   { render :partial => '/admin/shop/products/edit/shared/variant', :locals => { :variant => @shop_product_variant } }
      end
    rescue
      respond_to do |format|
        format.html {
          flash[:error] = error
          redirect_to edit_admin_shop_product_path(@shop_product)
        }
        format.js   { render :text  => error, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    notice  = 'Successfully destroyed variant.'
    error   = 'Could not destroy variant.'
    
    if @shop_product_variant.destroy
      respond_to do |format|
        format.html {
          redirect_to edit_admin_shop_product_path(@shop_product)
        }
        format.js   { render :text  => notice, :status => :ok }
      end
    else
      respond_to do |format|
        format.html {
          flash[:error] = error
          redirect_to edit_admin_shop_product_path(@shop_product)
        }
        format.js   { render :text  => error, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
  def find_product
    @shop_product = @shop_product_variant.product || ShopProduct.find(params[:product_id])
  end
  
end
