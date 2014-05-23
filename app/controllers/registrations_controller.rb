class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?
  respond_to :json

  def create
  	logger.info "Registered a Request..."
  	respond_to do |format|
  		format.html { super }
  		format.json {
  			logger.info "Register Json Request..."
  			user = User.new(new_user_params)
    		if user.save
      			render :json=> { :success=>true, :auth_token=>user.authentication_token, :email=>user.email, :status=>201 }
      			return
    		else
      			warden.custom_failure!
      			render :json=> user.errors, :status=>422
    		end
  		}
  	end
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:email, :password, :password_confirmation, :current_password)}
  end

  private

  	def new_user_params
  		params.require(:user).permit(:email, :password)
  	end
end
