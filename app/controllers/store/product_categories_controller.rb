class Store::ProductCategoriesController < ApplicationController
	before_action :get_department, only: [:new]
	before_action :set_category, only: [:show, :edit]
	before_action :get_manage
	layout "store_management", if: :manage? 

	def new
		@category = ProductCategory.new
	end

	def edit
	end

	def show
		@products = @category.products.ordered
	end

	def create
		@department = Department.find(category_params[:department_id])
		@categories = @department.product_categories.ordered
		@category = ProductCategory.new(category_params)

		respond_to do |f|
			if @category.save
				f.html { redirect_to store_manage_product_category_path(@category) }
				f.turbo_stream
			end
		end
	end

	private
		def get_manage
			if params[:manage] == true
				@manage = true
			end
		end

		def manage?
			@manage
		end
		
		def get_department
			@department = Department.find_by_id(params[:department_id])
		end

		def category_params
			params.require(:product_category).permit(:name, :slug, :department_id)
		end

		def set_category
			@category = ProductCategory.find_by(slug: params[:slug])
			@department = @category.department
		end
end
