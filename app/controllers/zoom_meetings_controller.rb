class ZoomMeetingsController < ApplicationController
	before_action :get_virtual_space, only: [:new, :create]
	before_action :set_meeting, only: :destroy

	def new
		@zoom = @virtual_space.zoom_meetings.build
		@event = Event.find(@virtual_space.event_id)
	end

	def create
		@zoom = @virtual_space.zoom_meetings.create(zoom_params)
		@event = Event.find(@virtual_space.event_id)
		@zoom.topic = "#{@event.title} (#{@zoom.room_type})"
		
		api_key = Rails.application.credentials.zoomus[:ZOOMUS_API_KEY]
		secret_key = Rails.application.credentials.zoomus[:ZOOMUS_SECRET_KEY]
		zoom_user_email = Rails.application.credentials.zoomus[:ZOOMUS_USER_EMAIL]
		jwt_payload = { iss: api_key,exp: 1.hour.from_now.to_i }
		
		token = JWT.encode(jwt_payload, secret_key, "HS256", {typ: "JWT"})
		
		url = URI("https://api.zoom.us/v2/users/#{zoom_user_email}/meetings")
		
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Post.new(url)
		request["authorization"] = "Bearer #{token}"
		request["content-type"] = "application/json"
		
		request.body = {
			topic: @zoom.topic,
			start_time: @event.start_time
		}.to_json

		res = http.request(request)
		res = JSON.parse(res.body)

		@zoom.meeting_id = res['id']
		@zoom.start_url = res['start_url']
		@zoom.join_url = res['join_url']

		respond_to do |format|
			if @zoom.save
				format.html { redirect_to virtual_space_path(@virtual_space) }
			else
				render :new
			end
		end
	end

	def destroy
		api_key = Rails.application.credentials.zoomus[:ZOOMUS_API_KEY]
		secret_key = Rails.application.credentials.zoomus[:ZOOMUS_SECRET_KEY]
		zoom_user_email = Rails.application.credentials.zoomus[:ZOOMUS_USER_EMAIL]
		jwt_payload = { iss: api_key,exp: 1.hour.from_now.to_i }
		
		token = JWT.encode(jwt_payload, secret_key, "HS256", {typ: "JWT"})
		
		url = URI("https://api.zoom.us/v2/users/#{zoom_user_email}/meetings/#{@zoom.meeting_id}")
		
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Delete.new(url.path)
		request["authorization"] = "Bearer #{token}"
		request["content-type"] = "application/json"
		
		res = http.request(request)
		#res = JSON.parse(res.body)

		@zoom.destroy
		redirect_to root_path, notice: "Deleted #{res.to_s}"
	end

	private
		def get_virtual_space
			@virtual_space = VirtualSpace.find(params[:virtual_space_id])
		end

		def zoom_params
			params.require(:zoom_meeting).permit(:room_type)
		end

		def set_meeting
			@zoom = ZoomMeeting.find(params[:id])
		end
end
