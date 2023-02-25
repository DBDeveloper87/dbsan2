class CreateCueBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :cue_blocks, id: :uuid do |t|
      t.references :text_track, null: false, foreign_key: true, type: :uuid
      t.integer :cue_num
      t.integer :cue_type
      t.string :cue_comment
      t.time :start
      t.time :end
      t.text :payload
      t.boolean :sdh
      t.integer :vertical, null: false, default: 0
      t.integer :line
      t.integer :line_type
      t.integer :position
      t.integer :size
      t.integer :align

      t.timestamps
    end
  end
end
