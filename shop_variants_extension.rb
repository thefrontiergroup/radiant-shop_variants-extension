# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class ShopVariantsExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/shop_variants"
  
  # extension_config do |config|
  #   config.gem 'some-awesome-gem
  #   config.after_initialize do
  #     run_something
  #   end
  # end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    unless defined? admin.variants
      Radiant::AdminUI.send :include, ShopVariants::Interface::Variants
      
      admin.variants = Radiant::AdminUI.load_default_shop_variants_regions
    end
    
    Admin::Shop::ProductsController.send :include, ShopVariants::Controllers::ProductsController
  end
end
