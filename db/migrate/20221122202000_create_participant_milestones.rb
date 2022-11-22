class CreateParticipantMilestones < ActiveRecord::Migration[7.0]
  def change
    create_table :participant_milestones, id: :uuid do |t|
      t.references :challenge_participant, null: false, foreign_key: true, type: :uuid
      t.references :challenge_milestone, null: false, foreign_key: true, type: :uuid
      t.datetime :earned_milestone_sent_at
      t.boolean :accept_prize
      t.boolean :shipped
      t.string :shipping_tracking
      t.datetime :shipped_notification_sent_at

      t.timestamps
    end
  end
end
