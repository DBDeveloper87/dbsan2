class Videos::CueBlocksController < ApplicationController
	before_action :set_block, only: [:edit, :update, :destroy]

	def edit
		@block.start = @block.start.strftime("%H:%M:%S.%L")
		@block.end = @block.end.strftime("%H:%M:%S.%L")
	end

	def update
		update_params[:start] = Time.zone.strptime(update_params[:start], "%H:%M:%S.%L")
		update_params[:end] = Time.zone.strptime(update_params[:end], "%H:%M:%S.%L")
		update_params[:payload] = update_params[:payload].reject { |e| e.empty? }

		if @block.update(update_params)
			respond_to do |f|
				@video = @block.video
				f.turbo_stream
			end
		end
	end

	def create
		track = TextTrack.find(create_params[:text_track_id])
		blocks = track.cue_blocks.order(cue_num: :asc)
		current_index = create_params[:current_block].to_i - 1
		length = blocks.length - 1
		if create_params[:insert_position] == "Above"
			blocks[current_index..length].each do |b|
				b.cue_num = b.cue_num + 1
				b.save
			end
		elsif create_params[:insert_position] == "Below"
			blocks[(current_index + 1)..length].each do |b|
				b.cue_num = b.cue_num + 1
				b.save
			end
		end

		if create_params[:cue_type] == "subtitles_and_captions"
			create_params[:payload] = []
		end

		@block = CueBlock.create(create_params)

		if @block.save
			@block.start = @block.start.strftime("%H:%M:%S.%L")
			@block.end = @block.end.strftime("%H:%M:%S.%L")
			unless @block.cue_type == "paragraph_break"
				if @block.payload.nil?
					@block.payload = []
				end
			end
			@blocks = track.cue_blocks.order(cue_num: :asc)
			@video = track.video
			respond_to do |f|
				f.turbo_stream
			end
		end
	end


	def destroy
		@blocks = @block.text_track.cue_blocks.order(cue_num: :asc)
		@video = @block.video
		if @block.destroy
			respond_to do |f|
				update_numbers_after_destroy
				f.turbo_stream
			end
		end
	end

	private
		def set_block
			@block = CueBlock.find(params[:id])
		end

		def create_params
			params.require(:cue_block).permit(:text_track_id, :insert_position, :current_block, 
				:cue_num, :cue_type, :start, :end, :sdh, payload: [])
		end

		def update_params
			params.require(:cue_block).permit(:start, :end, :sdh, payload: [])
		end

		def update_numbers_after_destroy
			current_index = @block.cue_num - 1
			length = @blocks.length - 1
			@blocks[current_index..length].each do |b|
				b.cue_num = b.cue_num - 1
				b.save
			end
		end

end
