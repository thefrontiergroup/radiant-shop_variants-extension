require 'spec/spec_helper'

describe Admin::Shop::Products::VariantTemplatesController do
  
  dataset :users, :shop_variants, :shop_product_variants
  
  before :each do
    login_as :admin
  end
  
  describe '#create' do
    before :each do
      @product = shop_products(:crusty_bread)
      @variant = shop_variants(:milk_states)
      @initial_product_variants = @product.variants.all
    end
    context 'successfully created' do
      before :each do
        stub(ShopProduct).find.with_any_args { @product }
        put :update, :product_id => @product.id, :id => @variant.id
      end
      it 'should add the variant templates to product' do
        final_variants = @product.variants.all
        final_variants.should_not == @initial_product_variants
        
        names = final_variants.map(&:name)
        @variant.options.each do |name|
          names.include?(name).should be_true
        end
      end
      it 'should redirect to edit product path' do
        response.should redirect_to(edit_admin_shop_product_path(@product))
      end
    end
    context 'could not create' do
      before :each do
        stub(ShopProduct).find.with_any_args { @product }
        mock(@product).apply_variant_template(@variant) { false }
        put :update, :product_id => @product.id, :id => @variant.id
      end
      it 'should not add the variant templates to product' do
        @product.variants.all.should == @initial_product_variants
      end
      it 'should assign flash error' do
        flash.now[:error].should_not be_nil
      end
      it 'should redirect to edit product path' do
        response.should redirect_to(edit_admin_shop_product_path(@product))
      end
    end
  end
  
end