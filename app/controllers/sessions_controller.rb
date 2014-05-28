class SessionsController < Devise::SessionsController
  before_filter :authenticate_user!, :except => [:create, :destroy]
  respond_to :json

  def create

    respond_to do |format|
      format.html { super }
      format.json {
        resource = User.find_for_database_authentication(:email => params[:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:password])
          sign_in(:user, resource)
          #resource.ensure_authentication_token!
          render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
          return
        end
        invalid_login_attempt
      }
    end
  end

  def destroy
    #resource = User.find_for_database_authentication(:email => params[:email])
    #resource.authentication_token = nil
    #resource.save
    #render :json=> {:success=>true}
    super
  end

  protected

  def invalid_login_attempt
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end

end