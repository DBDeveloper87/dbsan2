class Photo < ApplicationRecord
  belongs_to :product_image_set
  has_one_attached :file
end
