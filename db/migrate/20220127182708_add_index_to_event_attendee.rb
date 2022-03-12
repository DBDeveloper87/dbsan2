class AddIndexToEventAttendee < ActiveRecord::Migration[7.0]
  def change
    remove_index :event_attendees, ["event_id"], name: "index_event_attendees_on_event_id"
    remove_index :event_attendees, ["user_id"], name: "index_event_attendees_on_user_id"
    
    add_index :event_attendees, ["event_id"], name: "index_event_attendees_on_event_id", unique: true
    add_index :event_attendees, ["user_id"], name: "index_event_attendees_on_user_id", unique: true
  end
end
