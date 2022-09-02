class Photos::ImagesController < ApplicationController
	before_action :get_params, only: :new

	def new
		@photo = Image.new
	end

	private
		def get_params
			if params[:product_image_set_id].present?
				@image_set = ProductImageSet.find(params[:product_image_set_id])
			end
		end
end
