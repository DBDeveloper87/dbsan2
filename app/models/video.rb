class Video < ApplicationRecord
	belongs_to :channel

	has_one_attached :original_upload
	
end
