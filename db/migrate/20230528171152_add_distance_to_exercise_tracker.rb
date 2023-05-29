class AddDistanceToExerciseTracker < ActiveRecord::Migration[7.0]
  def change
    add_column :exercise_trackers, :distance, :float
    add_column :exercise_trackers, :distance_unit, :integer, null: false, default: 0
  end
end
