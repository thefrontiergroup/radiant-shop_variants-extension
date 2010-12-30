module ShopVariants
  module Models
    module Product
      
      def self.included(base)
        base.class_eval do
          has_many :variants, :class_name => 'ShopProductVariant', :foreign_key  => :product_id, :dependent => :destroy, :order => 'name ASC'
          
          accepts_nested_attributes_for :variants
        end
      end
      
    end
  end
end