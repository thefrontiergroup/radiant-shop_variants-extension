class ShopProductVariant < ActiveRecord::Base
  
  belongs_to :product, :class_name => 'ShopProduct', :foreign_key => :product_id
  
  validates_presence_of   :product
  validates_presence_of   :name
  validates_uniqueness_of :name, :scope => :product_id
  
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  
  has_many    :line_items,  :class_name => 'ShopLineItem',          :foreign_key  => :item_id,      :dependent => :destroy
  has_many    :orders,      :class_name => 'ShopOrder',             :through      => :line_items,   :uniq      => true
  has_many  :discountables, :class_name => 'ShopDiscountable',      :foreign_key  => :discounted_id
  has_many    :discounts,   :class_name => 'ShopDiscount',          :through      => :discountables
  
  # Returns the price of the variant plus the product price
  def price
    price = product.price
    if read_attribute(:price).present?
      price = read_attribute(:price) + product.price
    end
    price
  end
  
  # Returns a mixed sku of product and variant name
  def sku
    %{#{product.sku}-#{ShopProduct.to_sku(name)}}
  end
  
  # Returns slug of the product
  def slug
    product.slug
  end
  
  def url
    product.url
  end
  
end