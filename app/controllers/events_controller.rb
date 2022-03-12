class EventsController < ApplicationController
	before_action :set_event, only: [:edit, :update, :show]
	#before_action :set_time_zone, only: [:new]

	def index
		@events = Event.all
	end

	def new
		@zone = params[:my_zone]
		@event = Event.new
	end

	def edit
	end

	def show
		@attendees = @event.event_attendees.map { |m| m.user.profile }
		@full_name = (@attendees.map { |m| m.first_name } + @attendees.map { |m| m.last_name }).join(" ")
		#@attendee_name = @attendee.join(" ")
	end
	
	def create
		@event = Event.new(event_params)

		respond_to do |format|
      		if @event.save
      			format.html { redirect_to edit_event_path(@event), notice: 'Event was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		if @event.update(event_params)
        		format.html { redirect_to root_path, notice: 'Event was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end

    
    

    private
    	def set_time_zone
    		myZone = params[:my_zone]
    		@zone = myZone
    	end

    	def event_params
    		params.require(:event).permit(:title, :description, :start_time, :end_time, :has_virtual_space)
    	end

    	def set_event
    		@event = Event.find(params[:id])
    	end


end
