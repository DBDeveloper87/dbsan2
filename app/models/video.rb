class Video < ApplicationRecord
	belongs_to :channel

	has_one_attached :original_upload
	attribute :content_type
	#validate :valid_format?

	attribute :upload_size
	#validates :upload_size, comparison: { less_than_or_equal_to: 50000000000, message: "You can only upload a video that is 50GB or less."}
	
	def valid_format?
		self.content_type == "video/webm" || "video/mp4" || "video/mov"
	end
end
