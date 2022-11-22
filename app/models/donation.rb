class Donation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :challenge_participant, optional: true
  attribute :other_amount

  before_create :update_amount
  before_create :update_deci
  #after_update :check_milestones

  def update_amount
    if self.amount.nil?
      self.amount = (self.other_amount.to_i * 100).to_s
    end
  end

  def update_deci
    self.amount_deci = self.amount.to_i / 100.0
  end

  def check_milestones
    unless self.challenge_participant.nil? and self.paid.nil?
      participant = self.challenge_participant
      milestones = participant.challenge.milestones.where(milestone_type: "Fundraising").all.order(goal: :asc)
      
      participant_milestones = participant.milestones.all
      fundraising_milestones = []
    
      if participant_milestones.count > 0
        participant_milestones.each do |pm|
          if pm.challenge_milestone.milestone_type == "Fundraising"
            fundraising_milestones.append(pm.challenge_milestone)
          end
        end
      end

      if fundraising_milestones.count > 0
        fundraising_milestones.each do |fm|
          if fm.in?(milestones)
            milestones.delete(fm)
          end
        end
      end

      milestones = milestones.order(goal: :asc)

      milestones.each do |m|
        if participant.total_raised >= m.goal
          participant_milestone.create({challenge_participant_id: participant.id, challenge_milestone_id: m.id})
        end
      end
    end
  end
end
