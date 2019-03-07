class SessionsController < ApplicationController
  
  # before_action helper method call enforce_login method before 
  # every method invoked below except welcome and new
  # welcome render the welcome page which is visible to every user
  # new => render the login page for student and instructors
  # create => is the method which is invoked when the login form is submited
  before_action :enforce_login, :except => [:welcome, :new, :create]
  

  # default render welcome template
  def welcome
  end

  # default render new template
  def new
  end

  # default render instructor home page
  def instructor_home
  end

  # default render student home page
  def student_home  
  end

  def create
      email = params[:user][:email] # get posted param email , password and user type
      password = params[:user][:password]
      type = params[:user][:usertype]

      # check user type
      if type === "Instructor" 
          @instructor = Instructor.find_by_email(email) 
          if @instructor.present? &&  @instructor.matches_password?(password)
            session[:id] = @instructor.id
            session[:email] = @instructor.email
            session[:firstname] = @instructor.firstname
            session[:lastname] = @instructor.lastname
            session[:type] = type
            redirect_to '/instructor_home'
          else
              flash[:warning]="Incorrect email address or password!"
              render 'new' # go to login again
          end
      else 
        #student login
      end
  end


  def destroy
    session.delete(:id)  
    session.delete(:email)  
    session.delete(:firstname)  
    session.delete(:lastname)  
    session.delete(:type)  
    redirect_to welcome_path #redirect to welcome page
  end


end
