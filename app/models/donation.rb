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
    unless self.challenge_participant_id.nil? and self.paid.nil?
      total_raised = self.challenge_participant.total_raised

      participant = self.challenge_participant
      challenge_milestones = participant.challenge.milestones.where(milestone_type: "Fundraising").all.order(goal: :asc)
      participant_milestones = participant.milestones.all

      milestone_ids = []
      challenge_milestones.each do |m|
        milestone_ids.append(m.id)
      end

      participant_milestones.each do |m|
        if m.challenge_milestone_id.in?(milestone_ids)
          milestone_ids.delete(m.challenge_milestone_id)
        end
      end

      challenge_milestones = []
      milestone_ids.each do |m|
        challenge_milestones.append(ChallengeMilestone.find(m))
      end
      puts "\n\n-----\n\n"
      puts challenge_milestones
      puts "\n\n Number of Milestones" + challenge_milestones.count.to_s
      puts total_raised

      challenge_milestones.each do |m|
        if total_raised >= m.goal
          ParticipantMilestone.create({
            challenge_participant_id: participant.id,
            challenge_milestone_id: m.id
          })
          puts "\n\n"
          puts "A milestone has been successfully created"
        end
      end
    end
  end
end
