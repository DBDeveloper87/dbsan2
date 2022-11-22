class ChallengeParticipant < ApplicationRecord
  has_many :donations
  has_many :participant_milestones
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

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def serialize_address
    self.address = {line_1: self.line_1, line_2: self.line_2,
      city: self.city, state: self.state, zip: self.zip, country: self.country}
  end

  def milestones
    self.participant_milestones
  end

  def total_raised
    donations = self.donations.where(paid: true).all
    total = []
    donations.each do |d|
      total.append(d.amount_deci)
    end
    return total.sum
  end

end
