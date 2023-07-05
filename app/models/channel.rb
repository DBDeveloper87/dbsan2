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

	def member_list_options
		members = self.members.all.sort { |a, b| a.last_name <=> b.last_name}
		list = []
		members.each do |m|
			list.append([m.full_name, m.user.id])
		end
		return list
	end
end
