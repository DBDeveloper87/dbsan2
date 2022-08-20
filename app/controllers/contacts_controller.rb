class ContactsController < ApplicationController
	def new
    	@contact = Contact.new
  	end

  	def create
    	@contact = Contact.new(params[:contact])
    	@contact.request = request
    	
    	unless verify_recaptcha?(params[:recaptcha_token], 'contact')
      		flash.now[:error] = t('recaptcha.errors.verification_failed')
      		return redirect_to root_path
    	end
    
    	
    	respond_to do |f|
    		if @contact.deliver
      			f.html { redirect_to message_sent_path, notice: "Message sent" }
    		else
      			flash.now[:error] = 'Could not send message'
      			render :new
   	 		end
   	 	end
  	end
end
