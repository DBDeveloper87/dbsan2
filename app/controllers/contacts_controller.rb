class ContactsController < ApplicationController
	def new
    	@contact = Contact.new
  	end

  	def create
    	@contact = Contact.new(params[:contact])
    	@contact.request = request
    	recaptcha_valid = verify_recaptcha(model: @contact, action: 'contact')

    	if recaptcha_valid
    		@contact.deliver
      		redirect_to message_sent_path, notice: "Message sent" 
    	else
      		flash.now[:error] = 'Could not send message'
      		render :new
   	 	end
   	 end
end
