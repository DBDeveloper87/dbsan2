class Product < ApplicationRecord
  belongs_to :product_category
  has_many :product_image_sets

  scope :ordered, -> { order(name: :asc)}
end
