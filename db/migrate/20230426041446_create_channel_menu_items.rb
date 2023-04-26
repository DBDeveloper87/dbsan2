class CreateChannelMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :channel_menu_items, id: :uuid do |t|
      t.references :channel_menu, null: false, foreign_key: true, type: :uuid
      t.integer :position
      t.string :name
      t.string :icon_class
      t.string :external_url
      t.string :path
      t.boolean :open_tab

      t.timestamps
    end
  end
end
