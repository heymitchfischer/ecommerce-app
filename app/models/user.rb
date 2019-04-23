class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_products
  has_many :products, through: :user_products
  has_many :orders

  def products_in_cart
    user_products.where(removed_from_cart: false, order_id: nil)
  end

  def total_price_in_cart
    sum = 0

    products_in_cart.each do |user_product|
      sum += user_product.product[:price]
    end

    "$%.2f" % (sum / 100.00)
  end

  def total_price_in_cart_for_stripe
    sum = 0

    products_in_cart.each do |user_product|
      sum += user_product.product[:price]
    end

    sum
  end
end
