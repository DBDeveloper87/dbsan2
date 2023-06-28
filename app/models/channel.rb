class Channel < ApplicationRecord
	has_one :channel_owner
	belongs_to :subdomain
	has_one_attached :brand_logo
	has_many :channel_menus
	has_many :social_networks
	has_many :videos
	has_many :surveys
	has_one :portfolio
end
