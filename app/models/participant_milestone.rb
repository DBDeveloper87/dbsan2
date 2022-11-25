class ParticipantMilestone < ApplicationRecord
  belongs_to :challenge_participant
  belongs_to :challenge_milestone
  after_create :send_notification

  def send_notification
    if self.earned_milestone_sent_at.nil?
      ParticipantMilestoneMailer.earned_milestone(self).deliver_now
      self.earned_milestone_sent_at = Time.now
      self.save
    end
  end
end
