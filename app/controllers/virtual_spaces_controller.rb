class VirtualSpacesController < ApplicationController
	def show
		@virtual_space = VirtualSpace.find(params[:id])
		@zoom_meetings = @virtual_space.zoom_meetings.all
	end
end
