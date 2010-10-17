require 'spec/spec_helper'

describe Admin::Shop::Products::VariantsController do
  
  dataset :users, :shop_variants, :shop_product_variants
  
  before :each do
    login_as :admin
  end
  
  describe '#create' do
    before :all do
      @product = shop_products(:crusty_bread)
    end
    context 'successfully created' do
      before :each do
        mock.instance_of(ShopProductVariant).save! { true }
      end
      context 'html' do
        before :each do
          post :create, :product_id => @product.id, :shop_product_variant => { }
        end
        it 'should redirect to product path' do
          response.should redirect_to(edit_admin_shop_product_path(@product))
        end
      end
      context 'js' do
        before :each do
          post :create, :product_id => @product.id, :shop_product_variant => { }, :format => 'js'
        end
        it 'should render the partial' do
          response.should render_template('/admin/shop/products/edit/shared/_variant')
        end
      end
    end
    context 'could not be created' do
      before :each do
        mock.instance_of(ShopProductVariant).save! { raise ActiveRecord::RecordNotSaved }
      end
      context 'html' do
        before :each do
          post :create, :product_id => @product.id, :shop_product_variant => { }
        end
        it 'should assign flash error' do
          flash.now[:error].should_not be_nil
        end
        it 'should redirect to product path' do
          response.should redirect_to(edit_admin_shop_product_path(@product))
        end
      end
      context 'js' do
        before :each do
          post :create, :product_id => @product.id, :shop_product_variant => { }, :format => 'js'
        end
        it 'should not be success' do
          response.should_not be_success
        end
      end
    end
  end
  
  describe '#destroy' do
    before :each do
      @product = shop_products(:crusty_bread)
      @product_variant = shop_product_variants(:mouldy_crusty_bread)
    end
    describe 'successfully destroyed' do
      before :each do
        mock(ShopProductVariant).find(@product_variant.id.to_s) { @product_variant }
        stub(@product_variant).destroy { true }
      end
      context 'html' do
        before :each do
          delete :destroy, :product_id => @product.id, :id => @product_variant.id
        end
        it 'should redirect to product path' do
          response.should redirect_to(edit_admin_shop_product_path(@product_variant.product))
        end
      end
      context 'js' do
        before :each do
          delete :destroy, :product_id => @product.id, :id => @product_variant.id, :format => 'js'
        end
        it 'should render the partial' do
          response.should be_success
        end
      end
    end
    describe 'could not be destroyed' do
      before :each do
        mock(ShopProductVariant).find(@product_variant.id.to_s) { @product_variant }
        stub(@product_variant).destroy { false }
      end
      context 'html' do
        before :each do
          delete :destroy, :product_id => @product.id, :id => @product_variant.id
        end
        it 'should assign flash error' do
          flash.now[:error].should_not be_nil
        end
        it 'should redirect to product path' do
          response.should redirect_to(edit_admin_shop_product_path(@product_variant.product))
        end
      end
      context 'js' do
        before :each do
          delete :destroy, :product_id => @product.id, :id => @product_variant.id, :format => 'js'
        end
        it 'should not be success' do
          response.should_not be_success
        end
      end
    end
  end
  
end