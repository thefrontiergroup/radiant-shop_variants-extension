require 'spec/spec_helper'

describe ShopVariant do
  
  dataset :shop_variants, :shop_categories
  
  describe 'validations' do
    before :each do
      @variant = shop_variants(:bread_states)
    end
    
    context 'name' do
      it 'should require' do
        @variant.name = nil
        @variant.valid?.should  === false
      end
      it 'should be unique' do
        @other = shop_variants(:milk_states)
        @other.name = @variant.name
        @other.valid?.should    === false
      end
    end
    
    context 'options' do
      it 'should require' do
        @variant.options_json = nil
        @variant.valid?.should  === false
      end
    end
  end
  
end