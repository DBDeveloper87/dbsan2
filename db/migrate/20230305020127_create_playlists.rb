class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists, id: :uuid do |t|
      t.string :name
      t.text :description
      t.integer :sort_by
      t.integer :order

      t.timestamps
    end

    add_reference :videos, :playlist, foreign_key: true, type: :uuid
  end
end
