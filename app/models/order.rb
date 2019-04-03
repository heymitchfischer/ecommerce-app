class Order < ApplicationRecord
  belongs_to :user
  has_many :user_products

  def total_price
    sum = 0

    user_products.each do |user_product|
      sum += user_product.product[:price]
    end

    "$%.2f" % (sum / 100.00)
  end
end
