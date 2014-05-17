class HomeController < ApplicationController
  def index
    	@users = User.all
    	@complaint = Complaint.new
  end
end
