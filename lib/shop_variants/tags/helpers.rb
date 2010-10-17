module ShopVariants
  module Tags
    class Helpers
      class << self
        
        def current_product_variants(tag)
          result = nil
          
          if tag.locals.shop_product.present?
            result = tag.locals.shop_product.variants
          end
          
          result
        end
        
        def current_product_variant(tag)
          result = nil
          
          if tag.locals.shop_product_variant.present?
            result = tag.locals.shop_product_variant
          end
          
          result
        end
        
      end
    end
  end
end