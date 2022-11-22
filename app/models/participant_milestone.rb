class ParticipantMilestone < ApplicationRecord
  belongs_to :challenge_participant
  belongs_to :challenge_milestone
end
