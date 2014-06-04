class ComplaintsController < ApplicationController
before_action :set_complaint, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, :except => :create

	def index
		@complaints = current_user.complaints.all
	end

	def show
  	end

  	def new
    	@complaint = current_user.complaints.new
  	end
	
	def edit
  	end
	
	def create
		#if user is not signed in
		if current_user.nil?
 			# Store the form data in the session so we can retrieve it after login
			session[:complaint] = complaint_params
 			# Redirect the user to register/login
			redirect_to new_user_session_path
		else
		#if user_signed_in?
			@complaint = current_user.complaints.build(complaint_params)
			if @complaint.save
				flash[:success] = "Complaint created..."
				redirect_to complaints_url
			else
				render action: 'new'
			end
		end
	end

	def update
		if @complaint.update(complaint_params)
			flash[:success] = "Complaint updated..."
			redirect_to @complaint
		else
			reder action: 'edit'
		end
	end

	def destroy
    	@complaint.destroy
        redirect_to complaints_url
    end

  

	private

		def set_complaint
      		@complaint = Complaint.find(params[:id])
    	end

		def complaint_params
			params.require(:complaint).permit(:provoke, :quality, :radiation, :severity, :time, :note, :complaint_type, :onset)
		end

end