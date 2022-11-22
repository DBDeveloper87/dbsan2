class ChallengeMilestone < ApplicationRecord
	belongs_to :challenge
	has_many :participant_milestones
end
