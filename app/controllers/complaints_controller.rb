class ComplaintsController < ApplicationController
before_action :set_complaint, only: [:show, :edit, :update, :destroy]

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
		@complaint = current_user.complaints.build(complaint_params)
		if @complaint.save
			flash[:success] = "Complaint created..."
			redirect_to @complaint
		else
			render action: 'new'
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
			params.require(:complaint).permit(:provoke, :quality, :radiation, :severity, :time, :note)
		end

end