# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ShopVariantsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/shop_variants"
  
  def activate
    unless defined? admin.variants
      Radiant::AdminUI.send :include, ShopVariants::Interface::Variants
      
      admin.variants = Radiant::AdminUI.load_default_shop_variants_regions
    end
    
    Admin::Shop::ProductsController.send :include, ShopVariants::Controllers::ProductsController
    
    ShopProduct.send :include, ShopVariants::Models::Product
    Page.send        :include, ShopVariants::Tags::ProductVariant
  end
end
