require 'spec/spec_helper'

describe Shop::Tags::ProductVariant do
  
  dataset :pages, :shop_product_variants, :shop_products
  
  it 'should describe these tags' do
    Shop::Tags::ProductVariant.tags.sort.should == [
      'shop:product:variants',
      'shop:product:variants:each',
      'shop:product:variants:if_variants',
      'shop:product:variants:unless_variants',
      'shop:product:variant',
      'shop:product:variant:id',
      'shop:product:variant:name',
      'shop:product:variant:sku',
      'shop:product:variant:price'].sort
  end
  
  before :all do
    @page = pages(:home)
  end
  
  context 'tags' do
    
    before :each do
      @product = shop_products(:crusty_bread)
      @variant = shop_product_variants(:mouldy_crusty_bread)
      
      stub(Shop::Tags::Helpers).current_product(anything) { @product }
    end
    
    describe '<r:shop:product:variants>' do
      context 'variants exist' do
        it 'should render' do
          tag = %{<r:shop:product:variants>success</r:shop:product:variants>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end
      end
      
      context 'variants do not exist' do
        it 'should render' do
          @product.variants = []
          
          tag = %{<r:shop:product:variants>success</r:shop:product:variants>}
          exp = %{success}

          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:product:variants:if_variants>' do
      context 'success' do
        it 'should render' do
          tag = %{<r:shop:product:variants:if_variants>success</r:shop:product:variants:if_variants>}
          exp = %{success}
          @page.should render(tag).as(exp)
        end
      end

      context 'failure' do
        it 'should not render' do
          mock(Shop::Tags::Helpers).current_product_variants(anything) { [] }
            
          tag = %{<r:shop:product:variants:if_variants>failure</r:shop:product:variants:if_variants>}
          exp = %{}
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:product:variants:unless_variants>' do
      context 'success' do
        it 'should render' do
          mock(Shop::Tags::Helpers).current_product_variants(anything) { [] }
          
          tag = %{<r:shop:product:variants:unless_variants>success</r:shop:product:variants:unless_variants>}
          exp = %{success}
          @page.should render(tag).as(exp)
        end
      end

      context 'failure' do
        it 'should not render' do
          tag = %{<r:shop:product:variants:unless_variants>failure</r:shop:product:variants:unless_variants>}
          exp = %{}
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:product:variants:each>' do
      context 'success' do
        it 'should not render' do
          tag = %{<r:shop:product:variants:each><r:product:id /></r:shop:product:variants:each>}
          exp = @product.variants.map{ |p| p.product.id }.join('')
          @page.should render(tag).as(exp)
        end      
      end

      context 'failure' do
        it 'should not render' do
          mock(Shop::Tags::Helpers).current_product_variants(anything) { [] }
          
          tag = %{<r:shop:product:variants:each>failure</r:shop:product:variants:each>}
          exp = %{}
          @page.should render(tag).as(exp)
        end
      end
    end
    
    describe '<r:shop:product:variant>' do
      context 'variant exists in the context' do
        it 'should render' do
          mock(Shop::Tags::Helpers).current_product_variant(anything) { @variant }
          
          tag = %{<r:shop:product:variant>success</r:shop:product:variant>}
          exp = %{success}
          @page.should render(tag).as(exp)
        end
      end

      context 'product does not exist in the context' do
        it 'should not render' do
          mock(Shop::Tags::Helpers).current_product_variant(anything) { nil }
          
          tag = %{<r:shop:product:variant>failure</r:shop:product:variant>}
          exp = %{}
          @page.should render(tag).as(exp)
        end
      end
    end
    
    context '#attributes' do
      before :each do
        mock(Shop::Tags::Helpers).current_product_variant(anything) { @variant }
      end
      
      describe '<r:id />' do
        it 'should render the product id' do
          tag = %{<r:shop:product:variant:id />}
          exp = @variant.id.to_s
          @page.should render(tag).as(exp)
        end
      end
      describe '<r:name />' do
        it 'should render the product name' do
          tag = %{<r:shop:product:variant:name />}
          exp = @variant.name
          @page.should render(tag).as(exp)
        end
      end
      describe '<r:sku />' do
        it 'should render the product sku' do
          tag = %{<r:shop:product:variant:sku />}
          exp = @variant.sku
          @page.should render(tag).as(exp)
        end
      end
      describe '<r:price />' do
        it 'should render a standard price' do
          tag = %{<r:shop:product:variant:price />}
          exp = Shop::Tags::Helpers.currency(@variant.price,{})
        
          @page.should render(tag).as(exp)
        end
      end
    end
    
  end
  
end