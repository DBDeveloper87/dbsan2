class Admin::BylawArticlesController < Admin::AdminConsoleController
	before_action :get_bylaw, only: [:new, :create]
	before_action :set_article, only: [:edit, :update, :show]

	def new
		@article = @bylaw.bylaw_articles.build
	end

	def edit
	end

	def show
		@sections = @article.bylaw_article_sections.all.order(sec_num: :asc)
	end
	
	def create
		@article = @bylaw.bylaw_articles.create(bylaw_article_params)

		respond_to do |format|
      		if @article.save
        		format.html { redirect_to admin_bylaw_path(@bylaw), notice: 'Bylaws Draft was successfully created.' }
        	else
        		format.html { render :new }
        	end
    	end
    end

    def update
    	respond_to do |format|
      		if @article.update(bylaw_article_params)
        		format.html { redirect_to admin_bylaw_path(@bylaw), notice: 'Bylaws was successfully updated.' }
        	else
        		format.html { render :edit }
        	end
    	end
    end

    

    private
    	def get_bylaw
			@bylaw = Bylaw.find(params[:bylaw_id])
		end

    	def bylaw_article_params
    		params.require(:bylaw_article).permit(:roman_numeral, :title, :introduction)
    	end

    	def set_article
    		@article = BylawArticle.find(params[:id])
    	end
	
		
end
