class Upload < ApplicationRecord
	attribute :blob_info

	serialize :file_list

	before_create :parse
	before_create :make_records

	def parse
		self.file_list = JSON.parse(self.file_list, symbolize_names: true)
	end

	def make_records
		if self.for == "video"
			videos = []
			self.file_list.each do |f|
				video = {
					title: f[:name].split(".")[0]
				}
				videos.append(video)
			end

			videos = Video.create(videos)

			self.file_list.each_with_index do |f, i|
				f.store(:video_id, videos[i].id)
			end
		end
	end
end
