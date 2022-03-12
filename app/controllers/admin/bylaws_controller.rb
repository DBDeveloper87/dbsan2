class Admin::BylawsController < Admin::AdminConsoleController
	before_action :set_bylaw, only: [:edit, :show, :update]

	def index
		@bylaws = Bylaw.all
	end

	def new
		@bylaw = Bylaw.new
	end

	def edit
	end

	def show
		@articles = @bylaw.bylaw_articles.all
	end
	
	def create
		@bylaw = Bylaw.new(bylaw_params)

		respond_to do |format|
      		if @bylaw.save
        		format.html { redirect_to admin_bylaws_path, notice: 'Bylaws Draft was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		if @bylaw.update(bylaw_params)
        		format.html { redirect_to admin_bylaws_path, notice: 'Bylaws was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end

    

    private

    	def bylaw_params
    		params.require(:bylaw).permit(:title, :introduction)
    	end

    	def set_bylaw
    		@bylaw = Bylaw.find(params[:id])
    	end
end
