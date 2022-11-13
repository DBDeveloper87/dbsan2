class ChallengeParticipant < ApplicationRecord
  belongs_to :challenge
  belongs_to :user
  before_save :serialize_address
  serialize :addresses

  attribute :line_1
  attribute :line_2
  attribute :city
  attribute :state
  attribute :zip
  attribute :country

  def serialize_address
    self.address = {line_1: self.line_1, line_2: self.line_2,
      city: self.city, state: self.state, zip: self.zip, country: self.country}
  end

end
