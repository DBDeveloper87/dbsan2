class ProductCategory < ApplicationRecord
  belongs_to :department
  has_many :products

  scope :ordered, -> { order(name: :asc)}
end
