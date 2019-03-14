class Product < ApplicationRecord
  def price_format
    "$%.2f" % (price / 100.00)
  end
end
