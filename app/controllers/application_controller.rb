class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  #acts_as_token_authentication_handler_for User


def after_sign_in_path_for(resource)
 
 # save list if there is a temp_list in the session
 if session[:complaint].present?
 
 # save list
 @complaint = current_user.complaints.create(session[:complaint])
 
 # clear session
session[:complaint] = nil
 
 #redirect
flash[:notice] = "Sweet, logged in. Nice list, btw :)"
complaints_url
 
 else
 #if there is not temp list in the session proceed as normal
 super
 end
end

end
