class AddPositionToProductVariant < ActiveRecord::Migration
  def self.up
    add_column :shop_product_variants, :position, :integer

    ShopProduct.find_each do |p|
      i = 1
      p.variants.find_each do |v|
        v.update_attribute(:position, i)
        i += 1
      end
    end
  end

  def self.down
    remove_column :shop_product_variants, :position
  end
end
