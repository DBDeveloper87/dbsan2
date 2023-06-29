class CreateChannelMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_members, id: :uuid do |t|
      t.references :channel, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :role, default: 0
      t.boolean :event_manager, null: false, default: false
      t.boolean :video_manager, null: false, default: false
      t.boolean :survey_manager, null: false, default: false
      t.boolean :channel_admin, null: false, default: false

      t.timestamps
    end
  end
end
