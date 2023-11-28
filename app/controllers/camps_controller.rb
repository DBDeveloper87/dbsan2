class CampsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_camp, only: [:show, :edit, :update, :destroy]

	def index
		if params[:view].present?
			if params[:view] == "all"
				@camps = Camp.all
			elsif params[:view] == "current_user"
				@camps = current_user.camps.all
			end
		else
			@camps = Camp.all
		end
	end

	def new
		@camp = Camp.new
	end

	def edit
	end

	def show
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

    def update
		respond_to do |format|
      		if @camp.update(camp_params)
      			format.html { redirect_to camp_path(@camp) }
        	else
        		render :edit 
        	end
    	end
    end

	def destroy
    	@camp.destroy
    	redirect_to camps_path(view: "all")
    end
    
    private
		def camp_params
    		params.require(:camp).permit(:title, :start, :end, :app_url, :description)
    	end

    	def set_camp
    		@camp = Camp.find(params[:id])
			@applications = @camp.camp_applications
		end
end
