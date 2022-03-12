class ChangeColumnToZoomMeeting < ActiveRecord::Migration[7.0]
  def change
    change_column :zoom_meetings, :meeting_id, :string
  end
end
