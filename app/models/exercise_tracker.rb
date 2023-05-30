class ExerciseTracker < ApplicationRecord
  belongs_to :challenge_participant
  attribute :time_hour
  attribute :time_minute
  attribute :time_second
  has_one :photo, dependent: :destroy
  accepts_nested_attributes_for :photo
  enum distance_unit: {miles: 0, kilometers: 1}
  
  before_validation :convert_time, if: :for_time?
  after_create :check_milestones

  validates :activity, presence: true
  validates :time, presence: true, if: :for_time?
  validates :distance, presence: true, if: :for_distance?
  validates :distance_unit, presence: true, if: :for_distance?
  

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
    def for_time?
      self.challenge_participant.challenge.challenge_type == "for_time"
    end

    def for_distance?
      self.challenge_participant.challenge.challenge_type == "for_distance"
    end

    def convert_time
      hours = self.time_hour
      if hours == ""
        hours = 0
      end
      minutes = self.time_minute
      if minutes == ""
        minutes = 0
      end
      seconds = self.time_second
      if seconds == ""
        seconds = 0
      end

      self.time = Time.zone.strptime("#{hours}:#{minutes}:#{seconds}", "%H:%M:%S")
      

    end
end
