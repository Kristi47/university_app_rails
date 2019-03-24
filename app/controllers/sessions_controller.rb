class SessionsController < ApplicationController
  
  # before_action helper method call enforce_login method before 
  # every method invoked below except welcome and new
  # welcome render the welcome page which is visible to every user
  # new => render the login page for student and instructors
  # create => is the method which is invoked when the login form is submited
  before_action :enforce_login_instructor, :only => [:instructor_home]
  before_action :enforce_login_student, :only => [:student_home]
  before_action :enforce_login, :only => [:destroy]

  # default render welcome template
  def welcome
  end

  # default render new template
  # if there is a session check session type to render instructor or student home page
  # else render login page
  def new
    if session[:login]
      if session[:type] == "Instructor"
        redirect_to '/instructor_home' and return
      elsif session[:type] == "Student"
        redirect_to '/student_home' and return
      end
    else 
      render 'new' and return
    end
    
  end

  # default render instructor home page
  def instructor_home
  end

  # default render student home page
  def student_home  
      @courses=@current_user.courses
  end

  def create
      email = params[:user][:email] # get posted param email , password and user type
      password = params[:user][:password]
      type = params[:user][:usertype]

      # check user type
      if type == "Instructor" 
          @instructor = Instructor.find_by_email(email) 
          if @instructor.present? &&  @instructor.matches_password?(password)
            session[:id] = @instructor.id
            session[:email] = @instructor.email
            session[:firstname] = @instructor.firstname
            session[:lastname] = @instructor.lastname
            session[:type] = type
            session[:login] = true
            redirect_to '/instructor_home'
          else
              flash[:warning]="Incorrect email address or password!"
              render 'new' # go to login again
          end
      elsif type == "Student" 
        #student login
        @student = Student.find_by_email(email)
        if @student.present? &&  @student.matches_password?(password)
          session[:id] = @student.id
          session[:email] = @student.email
          session[:firstname] = @student.firstname
          session[:lastname] = @student.lastname
          session[:type] = type
          session[:login] = true
          redirect_to '/student_home'
        else
            flash[:warning]="Incorrect email address or password!"
            render 'new' # go to login again
        end
      end
  end


  def destroy
    session.delete(:id)  
    session.delete(:email)  
    session.delete(:firstname)  
    session.delete(:lastname)  
    session.delete(:type)  
    session.delete(:login)  
    redirect_to welcome_path #redirect to welcome page
  end



end
