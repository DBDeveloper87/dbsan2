class Store::DepartmentsController < ApplicationController
	before_action :set_department, only: [:show, :edit]
	before_action :get_manage
	layout "store_management", if: :manage? 

	def index
		@departments = Department.ordered
	end
	
	def new
		@department = Department.new
	end

	def edit
	end

	def show
		@categories = @department.product_categories.ordered
	end

	def create
		@departments = Department.ordered
		@department = Department.new(department_params)

		respond_to do |f|
			if @department.save
				f.html { redirect_to department_path(@department) }
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

		def department_params
			params.require(:department).permit(:name, :slug)
		end

		def set_department
			@department = Department.find_by(params[:slug])
		end

end
