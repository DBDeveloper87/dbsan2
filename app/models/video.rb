class Video < ApplicationRecord
	belongs_to :channel
	belongs_to :playlist, optional: true
	has_many :text_tracks
	has_many :cue_blocks, through: :text_tracks

	# Original Upload
	has_one_attached :original_upload

	# MP4 Files
	has_one_attached :mp4_4k
	has_one_attached :mp4_1080p
	has_one_attached :mp4_720p
	has_one_attached :mp4_480p

	# Transparent HEVC MOV
	has_one_attached :transparent_hevc_mov_4k
	has_one_attached :transparent_hevc_mov_1080p
	has_one_attached :transparent_hevc_mov_720p
	has_one_attached :transparent_hevc_mov_480p

	# Transparent VP9 Webm
	has_one_attached :transparent_vp9_webm_4k
	has_one_attached :transparent_vp9_webm_1080p
	has_one_attached :transparent_vp9_webm_720p
	has_one_attached :transparent_vp9_webm_480p
	
end
