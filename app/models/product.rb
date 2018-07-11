class Product < ApplicationRecord
  has_many :product_orders
  validates :name, :price, :unit, presence: true
end