class CreateZoomMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :zoom_meetings, id: :uuid do |t|
      t.string :topic
      t.references :virtual_space, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
