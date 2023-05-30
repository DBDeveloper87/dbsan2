class ChallengeParticipant < ApplicationRecord
  has_many :donations
  has_many :exercise_trackers
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

  def activities
    self.exercise_trackers
  end

  def total_time
    if self.challenge.challenge_type == "for_time"
      total = []
      activities = self.activities.all
      activities.each do |a|
        total.append(a.time)
      end
      return total.inject(0) { |sum, t| sum + ((t.hour * 60 + t.min + t.sec / 60).round) }
    else
      return 0
    end
  end

  def total_distance
    total = []
    activities = self.activities.all
    activities.each do |a|
      if a.distance_unit == "kilometers"
        total.append(a.distance * 0.621371)
      else
        total.append(a.distance)
      end
    end
    return total.sum
  end

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

  def fms_ids
    milestones = self.milestones
    ids = []
    milestones.each do |m|
      if m.challenge_milestone.milestone_type == "Fundraising"
        ids.append(m.challenge_milestone_id)
      end
    end

    return ids
  end

  def ems_ids
    milestones = self.milestones
    ids = []
    milestones.each do |m|
      if m.challenge_milestone.milestone_type == "Exercise"
        ids.append(m.challenge_milestone_id)
      end
    end

    return ids
  end

end
