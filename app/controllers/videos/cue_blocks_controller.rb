class Videos::CueBlocksController < ApplicationController
	before_action :set_block, only: [:edit, :update]

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
				f.turbo_stream
			end
		end
	end

	private
		def set_block
			@block = CueBlock.find(params[:id])
		end

		def update_params
			params.require(:cue_block).permit(:start, :end, :sdh, payload: [])
		end
end
