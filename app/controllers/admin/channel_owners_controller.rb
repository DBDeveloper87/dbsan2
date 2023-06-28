class Admin::ChannelOwnersController < Admin::AdminConsoleController

	def index
		@channels = Channel.order(name: :asc).all
	end

	def new
		@channel_id = params[:channel_id]
		@owner = ChannelOwner.new
	end

	def create
		@owner = ChannelOwner.create(create_params)

		if @owner.save
			redirect_to admin_channel_owners_path
		else
			render :new, status: :unprocessable_entity
		end
	end

	private
		def create_params
			params.require(:channel_owner).permit(:channel_id, :user_id)
		end
end
