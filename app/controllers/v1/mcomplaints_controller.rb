module V1
class McomplaintsController < ApplicationController
	#before_action :user_signed_in?
	before_action :verify_authenticity_token
	skip_before_action :verify_authenticity_token
	
	def index
		complaint = current_user.complaints.all
		render json: complaint, status: 200
	end

	def show
		complaint = current_user.complaints.find(params[:id])
		render json: complaint, status: 200
	end

	def create 
		
		complaint = current_user.complaints.new(complaint_params)
		if complaint.save
			render json: complaint, status: :created, location: complaint
		else
			render json: complaint.errors, status: 422
		end
	end

	def update
		complaint = current_user.complaints.find(params[:id])
		if complaint.update(complaint_params)
			render json: complaint, status: 200
		else
			render json: complain.erros, status: 422
		end
	end

	def destroy
		complaint = current_user.complaints.find(params[:id])
		complaint.destroy
		head 204
	end

	private

		def complaint_params
			params.require(:complaint).permit(:provoke, :quality, :radiation, :severity, :time, :note)
		end

end
end