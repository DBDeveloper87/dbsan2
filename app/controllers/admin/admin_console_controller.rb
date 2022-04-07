class Admin::AdminConsoleController < ApplicationController
	before_action :authenticate_user!
	before_action :require_admin
	layout "admin_console"
end
