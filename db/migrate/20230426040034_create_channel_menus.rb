class CreateChannelMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :channels, :navbar_bg, :string
    add_column :channels, :navbar_bg_invert, :string
    add_column :channels, :brand_bg, :string
    add_column :channels, :brand_bg_invert, :string
    
    

    create_table :channel_menus, id: :uuid do |t|
      t.string :location
      t.references :channel, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
