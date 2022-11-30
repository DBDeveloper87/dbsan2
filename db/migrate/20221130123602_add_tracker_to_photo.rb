class AddTrackerToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_reference :photos, :exercise_tracker, foreign_key: true, type: :uuid
  end
end
