require 'spec/spec_helper'

describe ShopProduct do
  
  dataset :shop_products
  
  before :each do
    @product = shop_products(:crusty_bread)
  end
  
  it 'should have many variants' do
    @product.variants.is_a?(Array).should be_true
  end
  
end