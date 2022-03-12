class AddRoomTypeToZoomMeeting < ActiveRecord::Migration[7.0]
  def change
    add_column :zoom_meetings, :room_type, :string
  end
end
