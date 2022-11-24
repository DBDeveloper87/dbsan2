class Challenge < ApplicationRecord
	has_one_attached :cover_image
	has_many :challenge_participants
	has_many :users, through: :challenge_participants
	has_many :donations, through: :challenge_participants
	has_many :challenge_milestones

	def milestones
		self.challenge_milestones
	end
end
