class CreateExerciseTrackers < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_trackers, id: :uuid do |t|
      t.references :challenge_participant, null: false, foreign_key: true, type: :uuid
      t.string :activity
      t.time :time
      t.text :comment

      t.timestamps
    end
  end
end
