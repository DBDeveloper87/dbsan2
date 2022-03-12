class Admin::SocialNetworksController < Admin::AdminConsoleController
	before_action :set_network, only: [:edit, :update]

	def index
		@networks = SocialNetwork.all
	end

	def new
		@network = SocialNetwork.new
	end

	def edit
	end
	
	def create
		@network = SocialNetwork.new(network_params)

		respond_to do |format|
      		if @network.save
        		format.html { redirect_to admin_social_networks_path, notice: 'Social Network was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		if @network.update(network_params)
        		format.html { redirect_to admin_social_networks_path, notice: 'Social Network was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end

    

    private

    	def network_params
    		params.require(:social_network).permit(:name, :icon_class, :url)
    	end

    	def set_network
    		@network = SocialNetwork.find(params[:id])
    	end
end
