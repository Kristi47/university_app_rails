class StudentsController < ApplicationController

    protect_from_forgery with: :exception
    before_action :enforce_login_instructor

    # display all students
    def index
        @students = Student.all
    end

    # show information for specific student
    def show
        id = params[:id]
        @student =Student.find id
    end

    # render new template
    def new
        @student = Student.new
        render 'new'
    end

    # when user submit the new form, to create a new user
    def create
        @student = Student.new(permitted_params)
        @student.valid?
        if @student.save
          flash[:notice] = "#{@student.firstname + " " + @student.lastname} was successfully created."
          redirect_to students_path
        else
          render 'new' and return
        end    
    end

    # render edit template with informaction fo the user
    def edit
        @student = Student.find params[:id]
    end

    # invoked when the edit form is submited
    def update
        @student = Student.find params[:id]
        @student.valid?
        if @student.update_attributes(permitted_params)
          flash[:notice] = "#{@student.email} was successfully updated."
          redirect_to student_path(@student)
        else
          render 'edit' and return
        end
    end

    # delete a student
    def destroy 
        id = params[:id]
        @student = Student.find(id)
        @student.destroy
        flash[:notice] = "#{@student.email} was succesfully deleted!"
        redirect_to students_path
    end

    def permitted_params
        params.require(:student)
        params[:student].permit(:firstname, :lastname, :email, :password)
    end
end