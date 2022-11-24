class Challenge < ApplicationRecord
	has_one :photo
	accepts_nested_attributes_for :photo

	has_many :challenge_participants
	has_many :users, through: :challenge_participants
	has_many :donations, through: :challenge_participants
	has_many :challenge_milestones

	def milestones
		self.challenge_milestones
	end
end
