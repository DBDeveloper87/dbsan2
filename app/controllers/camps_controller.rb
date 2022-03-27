class CampsController < ApplicationController
	def index
		@camps = Camp.all
	end

	def new
		@camp = Camp.new
	end

	def show
		@camp = Camp.find(params[:id])
		@applications = @camp.camp_applications
	end

	def create
		@camp = Camp.new(camp_params)

		respond_to do |format|
      		if @camp.save
      			format.html { redirect_to camp_path(@camp), notice: 'Camp or Retreat was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    private
		def camp_params
    		params.require(:camp).permit(:title, :start, :end, :description)
    	end
end
