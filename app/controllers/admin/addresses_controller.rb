class Admin::AddressesController < ApplicationController
	def filter_address
		if params[:country].present?
			if params[:parvalue] = nil
				@pi = nil
			else
				@pi = params[:parvalue]
			end

			if params[:country] == [" "]
				@states = []
			else
				@states = StateProvince.where(country_id: params[:country]).all.order(:name)
			end

			if @pi == nil
				render partial: "/admin/addresses/state_province"
			else
				render partial: "/admin/addresses/state_exist"
			end
			
			
				
		elsif params[:state_province].present?
			@counties = County.where(state_province_id: params[:state_province]).all.order(:name)
			render partial: "admin/addresses/county"
		end
	end
end
