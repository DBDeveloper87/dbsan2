class ExerciseTracker < ApplicationRecord
  belongs_to :challenge_participant
  attribute :time_hour
  attribute :time_minute
  attribute :time_second
  has_one :photo
  accepts_nested_attributes_for :photo

  before_create :convert_time
  after_create :check_milestones

  def check_milestones
    total_time = self.challenge_participant.total_time

    participant = self.challenge_participant
    challenge_milestones = participant.challenge.milestones.where(milestone_type: "Exercise").all.order(goal: :asc)
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
      
    challenge_milestones.each do |m|
      if total_time >= m.goal
        ParticipantMilestone.create({
          challenge_participant_id: participant.id,
          challenge_milestone_id: m.id
        })
      end
    end
  end

  private
    def convert_time
      hours = self.time_hour
      minutes = self.time_minute
      seconds = self.time_second

      self.time = Time.zone.strptime("#{hours}:#{minutes}:#{seconds}", "%H:%M:%S")
    end
end
