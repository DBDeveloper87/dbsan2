class CampApplicationTraining < ApplicationRecord
  belongs_to :camp_application

  serialize :training_history
end
