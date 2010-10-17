class SetupShopVariants < ActiveRecord::Migration
  def self.up
    create_table "shop_variants", :force => true do |t|
      t.string   "name"
      t.text     "options_json"
      t.integer  "created_by_id"
      t.integer  "updated_by_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "shop_product_variants", :force => true do |t|
      t.string  "name"
      t.decimal "price"
      t.integer "product_id"
    end
  end

  def self.down
  end
end
