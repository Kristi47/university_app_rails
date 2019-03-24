class InstructorsController < ApplicationController
    protect_from_forgery with: :exception

    before_action :enforce_login_instructor, :only => [:edit, :update, :show]


    # get instructor with specific id from session
    def show
      @instructor = Instructor.find_by_id(session[:id])
      # will render view/instructor/show/html/haml by default
    end

    # get the id of logged instrcutor from the session and use the id
    # to get all the profile information about the instrcutor
    def edit
        @instructor = Instructor.find_by_id(session[:id])
    end

    # get the id of instructor from session
    def update
      @instructor = Instructor.find_by_id(session[:id])

      # check if password and confirm password match
      if params[:instructor][:password] != params[:instructor][:password_match]
        flash[:notice] = "Your password and confirmation password do not mtach."
        render 'edit' and return #return is used to terminate the action
      end

      if @instructor.update_attributes(permitted_params)
        flash[:notice] = "Your profile was successfully updated."
        redirect_to instructor_home_path and return
      else
        render 'edit' and return #return is used to terminate the action
      end
    end

    private
    def permitted_params
        params.require(:instructor)
        params[:instructor].permit(:firstname, :lastname, :email, :password)
    end

  end
  