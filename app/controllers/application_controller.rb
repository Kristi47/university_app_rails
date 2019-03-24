class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 

  before_action :set_current_user

  protected
  def enforce_login
    set_current_user
    redirect_to login_path flash[:notice]= "You need to login"  and return unless @current_user
  end

  protected
  def enforce_login_student

    set_current_user
    unless @current_user
      redirect_to login_path flash[:notice]= "You need to login as a student" and return
    end
    if session[:type] != "Student"
      redirect_to login_path flash[:notice]= "You need to login as a student" and return
    end 
   
  end

  protected # prevents method from being invoked by a route
  def enforce_login_instructor
    # call method set_current_user which check user type and pass user object to instance variabel @current_user
    # if @current_user does not exists than the user is redirected to login page
    set_current_user
    unless @current_user
      redirect_to login_path flash[:notice]= "You need to login as an Instructor" and return
    end
    if session[:type] != "Instructor"
      redirect_to login_path flash[:notice]= "You need to login as an Instructor" and return
    end 
  end



  def set_current_user
    if session[:type] == "Instructor"
      @current_user ||= Instructor.find_by_id session[:id]
    elsif session[:type] == "Student"
      @current_user ||= Student.find_by_id session[:id]
    end
  end

end
