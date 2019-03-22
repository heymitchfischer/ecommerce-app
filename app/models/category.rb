class Category < ApplicationRecord
  has_many :products

  def self.ids
    Category.all.map { |cat| cat.id }
  end
end
