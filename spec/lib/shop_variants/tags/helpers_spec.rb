require 'spec/spec_helper'

describe ShopVariants::Tags::Helpers do
  
  dataset :pages, :shop_products, :shop_product_variants
  
  before :all do
    @page = pages(:home)
  end

  describe '#current_product_variants' do
    before :each do
      @product = shop_products(:crusty_bread)
    end
  
    context 'existing product variant' do
      it 'should return that existing line item' do
        @tag.locals.shop_product = @product
      
        result = Shop::Tags::Helpers.current_product_variants(@tag)
        result.should == @product.variants
      end
    end
  
    context 'nothing sent or available' do
      it 'should return nil' do
        result = Shop::Tags::Helpers.current_product_variants(@tag)
        result.should be_nil
      end
    end
  end

  describe '#current_product_variant' do
    before :each do
      @variant = shop_product_variants(:mouldy_crusty_bread)
    end
  
    context 'existing product variant' do
      it 'should return that existing variant' do
        @tag.locals.shop_product_variant = @variant
      
        result = Shop::Tags::Helpers.current_product_variant(@tag)
        result.should == @variant
      end
    end
  
    context 'nothing sent or available' do
      it 'should return nil' do
        result = Shop::Tags::Helpers.current_product_variant(@tag)
        result.should be_nil
      end
    end
  end