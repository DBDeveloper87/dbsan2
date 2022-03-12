class CreateEventAttendees < ActiveRecord::Migration[7.0]
  def change
    create_table :event_attendees, id: :uuid do |t|
      t.references :event, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
