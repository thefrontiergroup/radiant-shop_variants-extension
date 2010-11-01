module ShopVariants
  module Controllers
    module ProductsController
      
      def self.included(base)
        base.class_eval do
          before_filter :config_global_variants
          before_filter :config_index_variants,  :only => [ :index ]
          before_filter :config_edit_variants,   :only => [ :edit, :update ]
          before_filter :assets_edit_variants,   :only => [ :edit, :update ]
          
          def config_global_variants
            @parts    << 'variants'
          end
          
          def config_index_variants
            @buttons  << 'variants'
          end
          
          def config_edit_variants
            @buttons  << 'browse_templates'
            @buttons  << 'new_variant'
            
            @popups   << 'browse_templates'
            @popups   << 'new_variant'
          end
          
          def assets_edit_variants
            include_stylesheet 'admin/extensions/shop/variants/edit'
            
            include_javascript 'admin/extensions/shop/variants/edit'
            
            @routes << {
              :name => 'admin_shop_product_variant_path',
              :path => admin_shop_product_variant_path(@shop_product, ':id')
            }
          end
          
        end
      end
      
    end
  end
end