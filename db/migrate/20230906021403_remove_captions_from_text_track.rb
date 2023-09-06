class RemoveCaptionsFromTextTrack < ActiveRecord::Migration[7.0]
  def change
    remove_column :text_tracks, :captions
  end
end
