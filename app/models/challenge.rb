class Challenge < ApplicationRecord
	has_many :challenge_participants
	has_many :users, through: :challenge_participants
end
