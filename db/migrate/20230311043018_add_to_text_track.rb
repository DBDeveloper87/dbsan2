class AddToTextTrack < ActiveRecord::Migration[7.0]
  def change
    add_column :text_tracks, :captions, :text
  end
end
