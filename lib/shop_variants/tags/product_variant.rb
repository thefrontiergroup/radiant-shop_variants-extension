module ShopVariants
  module Tags
    module ProductVariant
      include Radiant::Taggable
      
      tag 'shop:product:variants' do |tag|
        tag.locals.shop_product_variants = Helpers.current_product_variants(tag)
        
        tag.expand
      end
      
      tag 'shop:product:variants:if_variants' do |tag|
        tag.expand if tag.locals.shop_product_variants.present?
      end
      
      tag 'shop:product:variants:unless_variants' do |tag|
        tag.expand if tag.locals.shop_product_variants.empty?
      end

      tag 'shop:product:variants:each' do |tag|
        content = ''
        
        tag.locals.shop_product_variants.each do |variant|
          tag.locals.shop_product_variant = variant
          content << tag.expand
        end
        
        content
      end
      
      tag 'shop:product:variant' do |tag|
        tag.locals.shop_product_variant = Helpers.current_product_variant(tag)
        tag.expand if tag.locals.shop_product_variant.present?
      end
      
      [:id, :name, :sku].each do |symbol|
        desc %{ outputs the #{symbol} of the current shop variant }
        tag "shop:product:variant:#{symbol}" do |tag|
          tag.locals.shop_product_variant.send(symbol)
        end
      end
      
      desc %{ output price of variant }
      tag 'shop:product:variant:price' do |tag|
        attr = tag.attr.symbolize_keys
        
        Helpers.currency(tag.locals.shop_product_variant.price,attr)
      end
      
    end
  end
end