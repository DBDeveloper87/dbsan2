class Video < ApplicationRecord
	belongs_to :channel
	belongs_to :playlist
	has_many :text_tracks
	has_many :cue_blocks, through: :text_tracks

	has_one_attached :original_upload
	
end
