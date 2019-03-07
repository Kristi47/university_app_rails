class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 

  before_action :set_current_user

  protected # prevents method from being invoked by a route
  def enforce_login
    # call method set_current_user which check user type and pass user object to instance variabel @current_user
    # if @current_user does not exists than the user is redirected to login page
    set_current_user
    redirect_to login_path flash[:notice]='You need to Login' and return unless @current_user
  end

  

  def set_current_user
    if session[:type] === "Instructor"
      @current_user ||= Instructor.find_by_id session[:email]
    end
  end

end
