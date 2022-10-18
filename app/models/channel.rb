class Channel < ApplicationRecord
	belongs_to :subdomain
	has_one_attached :brand_logo
	has_many :videos
end
