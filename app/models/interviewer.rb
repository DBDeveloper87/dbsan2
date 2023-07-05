class Interviewer < ApplicationRecord
  belongs_to :survey
  belongs_to :user
  has_many :survey_response

  def first_name
    self.user.profile.first_name
  end

  def last_name
    self.user.profile.last_name
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
