class Store::ProductImageSetsController < ApplicationController
	before_action :get_product, only: [:new, :index]
	before_action :get_manage
	before_action :set_image_set, only: [:show, :update]
	layout "store_management", if: :manage? 

	def index
		@image_sets = @product.product_image_sets.ordered

		if :manage?
			render partial: "store/product_image_sets/index_manage", locals: {
				image_sets: @image_sets,
				product: @product
			}, layout: "store_management"
		end
	end

	def new
		@image_set = ProductImageSet.new
	end

	def show
		
	end

	def create
		@image_set = ProductImageSet.new(image_set_params)
		@product = @image_set.product
		@image_sets = @product.product_image_sets.ordered

		if @image_set.save
			respond_to do |f|
				f.turbo_stream
			end
		end
	end

	def update
		@product = @image_set.product
		@image_sets = @product.product_image_sets

		if @image_set.update(image_set_params)
			respond_to do |f|
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

		def get_product
			@product = Product.find(params[:product])
		end

		def set_image_set
			@image_set = ProductImageSet.find(params[:id])
		end



		def image_set_params
			params.require(:product_image_set).permit(:label, :product_id, 
				photos_attributes: [ :id, :label, :image_type, :alt_text, :description, :file])
		end
end
