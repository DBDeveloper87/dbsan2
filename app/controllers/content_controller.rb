class ContentController < ApplicationController

	def block
		@position = params[:position]
		render partial: "content/blocks/paragraph"
	end
end
