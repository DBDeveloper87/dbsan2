class AddSynTextToCueBlock < ActiveRecord::Migration[7.0]
  def change
    add_column :cue_blocks, :synthesize_text, :text
    add_column :cue_blocks, :ssml, :text
  end
end
