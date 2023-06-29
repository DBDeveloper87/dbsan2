class Channel < ApplicationRecord
	has_one :channel_owner
	has_many :channel_members
	belongs_to :subdomain
	has_one_attached :brand_logo
	has_many :channel_menus
	has_many :social_networks
	has_many :videos
	has_many :surveys
	has_one :portfolio

	def members
		self.channel_members
	end

	def owner
		self.channel_owner
	end
end
