class Department < ApplicationRecord
	has_many :product_categories
	has_many :products, through: :product_categories

	scope :ordered, -> { order(name: :asc) }
end
