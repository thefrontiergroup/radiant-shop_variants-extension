require 'admin/shop/products_controller'

class ShopVariantsExtension < Radiant::Extension
  version YAML::load_file(File.join(File.dirname(__FILE__), 'VERSION'))
  description "Create variants of products, with alternative prices"
  url "https://github.com/thefrontiergroup/radiant-shop_variants-extension"
  
  def activate
    unless defined? admin.variants
      Radiant::AdminUI.send :include, ShopVariants::Interface::Variants
      
      admin.variants = Radiant::AdminUI.load_default_shop_variants_regions
    end
    
    ::Admin::Shop::ProductsController.send :include, ShopVariants::Controllers::ProductsController
    
    ShopProduct.send :include, ShopVariants::Models::Product
    Page.send        :include, ShopVariants::Tags::ProductVariant
  end
end
