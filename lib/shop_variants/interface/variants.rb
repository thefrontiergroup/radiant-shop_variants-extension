module ShopVariants
  module Interface
    module Variants
      
      def self.included(base)
        base.send :include, InstanceMethods
      end
      
      module InstanceMethods
        attr_accessor :variants
        
        protected

        def load_default_shop_variants_regions
          returning OpenStruct.new do |variants|
            variants.edit = Radiant::AdminUI::RegionSet.new do |edit|
              edit.main.concat %w{head form popups}
              edit.form.concat %w{inputs meta parts foot}
              edit.foot.concat %w{buttons timestamp}
            end
            variants.new = variants.edit
            variants.index = Radiant::AdminUI::RegionSet.new do |index|
              index.head.concat %w{}
              index.body.concat %w{name modify}
              index.foot.concat %w{buttons}
            end
            variants.remove = variants.index
          end
        end
      end
      
    end
  end
end