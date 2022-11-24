class ChallengeMilestone < ApplicationRecord
	belongs_to :challenge
	has_many :participant_milestones
	has_one :photo
	accepts_nested_attributes_for :photo
end
