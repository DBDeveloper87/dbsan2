class ProductImageSet < ApplicationRecord
  belongs_to :product
  has_many :images
end
