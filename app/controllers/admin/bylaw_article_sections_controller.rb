class Admin::BylawArticleSectionsController < Admin::AdminConsoleController
	before_action :get_article, only: [:new, :create]
	before_action :set_section, only: [:edit, :update, :show, :destroy]


	def new
		@section = @article.bylaw_article_sections.build
	end

	def edit
	end

	def show
	end

	def create
		@section = @article.bylaw_article_sections.create(article_section_params)

		respond_to do |format|
      		if @section.save
        		format.html { redirect_to admin_bylaw_article_path(@article), notice: 'Bylaws Draft was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		if @section.update(article_section_params)
        		format.html { redirect_to admin_bylaw_article_path(@section.bylaw_article_id), notice: 'Bylaws was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end

    def destroy
    	@section.destroy
    end

	private
    	def get_article
			@article = BylawArticle.find(params[:bylaw_article_id])
		end

    	def article_section_params
    		params.require(:bylaw_article_section).permit(:sec_num, :title, :content)
    	end

    	def set_section
    		#article = BylawArticle.find(params[:bylaw_article_id])
    		@section = BylawArticleSection.find(params[:id])
    	end
	
	
end
