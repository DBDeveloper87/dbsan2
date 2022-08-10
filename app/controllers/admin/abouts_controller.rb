class Admin::AboutsController < Admin::AdminConsoleController
	before_action :set_section, only: [:edit, :update, :publish]

	def index
		@sections = About.all
	end
	
	def new
		@section = About.new
	end

	def edit
	end
	
	def create
		@section = About.new(section_params)

		respond_to do |format|
      		if @section.save
        		format.html { redirect_to admin_abouts_path, notice: 'Event was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		if @section.update(section_params)
        		format.html { redirect_to admin_abouts_path, notice: 'Event was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end
    
    private

    	def section_params
    		params.require(:about).permit(:title, :heading_level, :content, :published)
    	end

    	def set_section
    		@section = About.find(params[:id])
    	end
end
