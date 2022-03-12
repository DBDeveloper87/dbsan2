class Admin::BylawArticleSubsectionsController < Admin::AdminConsoleController
	before_action :get_section, only: [:new, :create]
	before_action :set_subsection, only: [:edit, :update, :show, :destroy]


	def new
		@subsection = @section.bylaw_article_subsections.build	
	end

	def edit
	end

	def show
	end

	def create
		@subsection = @section.bylaw_article_subsections.create(subsection_params)	

		respond_to do |format|
      		if @subsection.save
        		format.html { redirect_to admin_bylaw_article_path(@section.bylaw_article_id), notice: 'Bylaws Draft was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		if @subsection.update(subsection_params)
        		format.html { redirect_to admin_bylaw_article_path(@subsection.bylaw_article_id), notice: 'Bylaws was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end

    def destroy
    	@subsection.destroy
    end

	private
    	def get_section
			#@article = BylawArticle.find(params[:bylaw_article_id])
			@section = BylawArticleSection.find(params[:bylaw_article_section_id])
		end

    	def subsection_params
    		params.require(:bylaw_article_subsection).permit(:subsec_num, :title, :content, :bylaw_article_id)
    	end

    	def set_subsection
    		@subsection = BylawArticleSubsection.find(params[:id])
    		
    		
    	end
	
	
end
