class CreateChallengeMilestones < ActiveRecord::Migration[7.0]
  def change
    create_table :challenge_milestones, id: :uuid do |t|
      t.string :milestone_type
      t.string :name
      t.integer :goal
      t.string :goal_unit
      t.string :prize
      t.references :challenge, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
