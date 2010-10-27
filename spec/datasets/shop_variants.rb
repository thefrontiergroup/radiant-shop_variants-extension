class ShopVariantsDataset < Dataset::Base  
  
  def load
    create_record :shop_variants, :bread_states,
      :name         => 'bread states',
      :options_json => ActiveSupport::JSON.encode([ 'mouldy', 'fresh' ])
      
    create_record :shop_variants, :milk_states,
      :name         => 'milk states',
      :options_json => ActiveSupport::JSON.encode([ 'cold', 'warm', 'sour' ])
      
    create_record :shop_variants, :salad_states,
      :name         => 'milk states',
      :options_json => ActiveSupport::JSON.encode([ 'fresh', 'wilted' ])
  end
  
end