class Admin::PoliciesController < Admin::AdminConsoleController
	before_action :set_policy, only: [:edit, :update]
	
	def index
		@policies = Policy.all
	end

	def new
		@policy = Policy.new
	end

	def edit
	end
	
	def create
		@policy = Policy.new(policy_params)
		@policy.published = false

		respond_to do |format|
      		if @policy.save
        		format.html { redirect_to admin_policies_path, notice: 'Policy was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		if @policy.update(policy_params)
        		format.html { redirect_to admin_policies_path, notice: 'Policy was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end

    

    private

    	def policy_params
    		params.require(:policy).permit(:title, :content, :copy_protect, :published, :published_at)
    	end

    	def set_policy
    		@policy = Policy.find(params[:id])
    	end
end
