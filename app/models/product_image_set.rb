class ProductImageSet < ApplicationRecord
  belongs_to :product
  has_many :photos
  accepts_nested_attributes_for :photos

  scope :ordered, -> { order(label: :asc)}
end
