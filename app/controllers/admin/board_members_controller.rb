class Admin::BoardMembersController < Admin::AdminConsoleController
	before_action :set_member, only: [:edit, :update]

	def index
		@board = BoardMember.all
	end

	def new
		@member = BoardMember.new
	end

	def edit
	end
	
	def create
		@member = BoardMember.new(member_params)

		respond_to do |format|
      		if @member.save
        		format.html { redirect_to admin_board_members_path, notice: 'Board Member was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		

      		if @member.update(member_params)
        		format.html { redirect_to admin_board_members_path, notice: 'Board Member was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end

    

    private

    	def member_params
    		params.require(:board_member).permit(:name, :position, :bio, 
    			pronouns: [] )
    	end

    	def set_member
    		@member = BoardMember.find(params[:id])
    	end

end
