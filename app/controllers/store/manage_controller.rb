class Store::ManageController < ApplicationController
	layout 'store_management'

	def index
		if params[:products] == "all"
			render partial: "store/products/index"
		end
	end
end
