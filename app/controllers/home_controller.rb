class HomeController < ApplicationController
  def index
  	if signed_in?
    	@users = User.all
    	@complaint = Complaint.new
    end
  end
end
