class CoursesController < ApplicationController

    before_action :enforce_login_instructor, :only => [:new, :create, :edit, :update, :destroy, :index_students, :add_student, :remove_student]
    
    # get all the courses 
    def index
        #instructor_id =session[:id]
        #@courses = Course.where(["instructor_id = ?", instructor_id])
        @courses = Course.all
    end

    # method to show information for a specific course by course ID
    def show
        @id = params[:id] #this is the id of the course, used in template to create a link to show the studetns of a course
        @course = Course.find_by_id(params[:id])
    end

    # function to render the template to create a new course
    def new
        @course = Course.new
        render 'new'
    end

    def create
        @course = Course.new(permitted_params) #call permitted_params to check the parameters that are posted
        if @course.save
            # show the flash message and redirect to course index
            flash[:notice] = "#{@course.name} was successfully created."
            redirect_to courses_path
        else
            # if error render again the new template and this will show the erros from the courses model
            render 'new' and return
        end    
    end

    #function to render the template for editing a specific course
    def edit
        @course = Course.find_by_id(params[:id])
    end

    def update
        # get the course information for the specific id
        # than update the course information
        # if success redirect to course index and show a message
        # else render the edit template again and show the errors
        @course = Course.find_by_id(params[:id])
        if @course.update_attributes(permitted_params)
            flash[:notice] = "#{@course.name} was successfully updated."
            redirect_to course_path(@course)
        else
            render 'edit' and return
        end
    end

    # function to delete a specific course
    def destroy
        @course = Course.find_by_id(params[:id])
        if @course.destroy
            flash[:notice] = "#{@course.name} was succesfully deleted!"
            redirect_to courses_path
        else
            render 'index' and return
        end
    end
        

    def index_students
        @course = Course.find_by_id(params[:course_id]) # find the course by id
        @students= @course.students #all students that belong to the course
        @allstudents = Student.all - @students # get all studetns that dont belong in any course and display tham in a dropdown
    end

    def add_student
        id = params[:course_id]
        @course = Course.find_by_id(id)
        student = Student.find(params[:student])
        @course.students << student
        redirect_to '/courses/'+id+'/index_students'
    end

    def remove_student
        id = params[:course_id]
        @course = Course.find_by_id(id)
        student = params[:data]
        @course.students.delete(student)
        redirect_to '/courses/'+id+'/index_students'
    end

    def permitted_params
        params.require(:course)
        params[:course] [:instructor_id] = @current_user.id #get the id of the login user from @current_user
        params[:course].permit(:code, :name, :semester_offered, :catalog_data, :instructor_id)
    end
end