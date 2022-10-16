class UploadsController < ApplicationController
	def index
	end

	def new
		@upload = Upload.new
	end

	def close
		respond_to do |f|
			f.turbo_stream
		end
	end
	def create
		@upload = Upload.create(upload_params)

		if @upload.save
			if upload_params[:for] == "video"
				@videos = []
				@upload.file_list.each do |f|
					@videos.append(Video.find_by(id: f[:video_id]))
				end
				respond_to do |f|
					f.turbo_stream
				end
			end			 
		end
	end

	def update
		@upload = Upload.find_by(id: params[:id])

		@blob_info = JSON.parse(upload_params[:blob_info], symbolize_names: true)
		file_list = @upload.file_list
		file_list.each do |f|
			if f[:list_index] == @blob_info[:list_index]
				if @upload.for == "video"
					video = Video.find_by(id: f[:video_id])
					video.original_upload = @blob_info[:blob_id]
					video.save
				end
				f[:status] = "complate"
			end
		end

		if @upload.update(upload_params)
			respond_to do |f|
				f.turbo_stream
			end
		end
	end

	private

		def upload_params
			params.require(:upload).permit(:file_list, :for, :for_id, :input_id, :blob_info)
		end

end
