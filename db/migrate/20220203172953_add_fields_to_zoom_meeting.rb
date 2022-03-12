class AddFieldsToZoomMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :zoom_meetings, :meeting_id, :integer
    add_column :zoom_meetings, :start_url, :text
    add_column :zoom_meetings, :join_url, :text
  end
end
