class Store::Manage::OrdersController < ApplicationController
	def index
		render partial: "store/manage/orders/index", layout: false
	end
end
