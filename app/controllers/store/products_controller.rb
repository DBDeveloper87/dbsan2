class Store::ProductsController < ApplicationController
	before_action :get_product_category, only: :new
	before_action :set_product, only: :show
	before_action :get_manage
	layout "store_management", if: :manage? 

	def index
	end

	def new
		@product = Product.new
	end

	def show
		@image_sets = @product.product_image_sets.all

		render partial: "show", locals: {
			product: @product, image_sets: @image_sets,
			category: @category, department: @department
		}, layout: "store_management"
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			@category = @product.product_category
			@department = @category.department
			@image_sets = @product.product_image_sets

			respond_to do |f|
				f.html { redirect_to product_path(@product) }
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
		
		def get_product_category
			@category = ProductCategory.find(params[:product_category_id])
		end

		def product_params
			params.require(:product).permit(:name, :description, :product_category_id)
		end

		def set_product
			@product = Product.find(params[:id])
			@category = @product.product_category
			@department = @category.department
		end
end
