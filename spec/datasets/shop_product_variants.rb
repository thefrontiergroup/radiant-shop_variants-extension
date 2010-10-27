class ShopProductVariantsDataset < Dataset::Base  
  
  uses :shop_products
  
  def load
    create_record :shop_product_variants, :mouldy_crusty_bread,
      :name     => 'mouldy',
      :price    => -2.50,
      :product  => shop_products(:crusty_bread)
    
    create_record :shop_product_variants, :fresh_crusty_bread,
      :name     => 'fresh',
      :price    => 2.50,
      :product  => shop_products(:crusty_bread)
      
    create_record :shop_product_variants, :royal_soft_bread,
      :name     => 'royal',
      :price    => 2.50,
      :product  => shop_products(:soft_bread)
  end
  
end