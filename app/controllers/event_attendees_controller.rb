class EventAttendeesController < ApplicationController
	before_action :get_event, only: [:new, :create]

	def new
		@event_attendee = @event.event_attendees.build
	end

	def create
		@event_attendee = @event.event_attendees.create(event_attendee_params)

		respond_to do |format|
      		if @event_attendee.save
        		format.html { redirect_to event_path(@event), notice: 'Event was successfully created.' }
        	else
        		format.html { redirect_to @event, notice: "You are already registered for this event" }
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
		def get_event
			@event = Event.find(params[:event_id])
		end

		def event_attendee_params
    		params.require(:event_attendee).permit(:event_id, :user_id)
    	end

end
