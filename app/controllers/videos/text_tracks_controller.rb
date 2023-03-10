class Videos::TextTracksController < ApplicationController
	before_action :get_video, only: [:index, :new, :create]
	before_action :set_track, only: [:edit, :show, :update]
	layout "videos"

	def index
		@tracks = @video.text_tracks.all
	end

	def new
		@track = @video.text_tracks.build
	end

	def show
	end

	def create
		@track = @video.text_tracks.create(create_params)

		if @track.save
			respond_to do |f|
				f.turbo_stream
			end
		end
	end

	def update
		if update_params[:file_import].present?
			@file = File.read(update_params[:file_import])
			
			if @track.update(update_params)
				@track.process_import(@file)

				respond_to do |f|
					@blocks = @track.cue_blocks
					@video = @track.video
					f.turbo_stream
				end
			end
		end
	end

	

	private
		def get_video
			@video = Video.find(params[:video_id])
		end

		def set_track
			@track = TextTrack.find(params[:id])
			@video = @track.video
		end

		def create_params
			params.require(:text_track).permit(:label, :language_id)
		end

		def update_params
			params.require(:text_track).permit(:file_import)
		end
end
