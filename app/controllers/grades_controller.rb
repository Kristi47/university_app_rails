class GradesController < ApplicationController

    before_action :enforce_login
    before_action :enforce_login_instructor , except: [:index, :show]

    def index
        @student = Student.find params[:student_id]
        @course = Course.find params[:course_id]
        @assessmentids = @course.assessmentitems.map(&:id)
        @grades = Grade.where('assessmentitem_id IN (:assessmentids) and student_id = :studentid', :assessmentids => @assessmentids, :studentid => @student.id)
    end
    
    def new
      @course = Course.find params[:course_id]
      @assessmentitems = @course.assessmentitems
      @grade=Grade.new
    end
    
    def create
      @course = Course.find params[:course_id]
      @assessmentitems = @course.assessmentitems
      @grade = Grade.new(permitted_params)
      
      if @grade.save
        flash[:notice] = "Grade was successfully created."
        redirect_to '/courses/' + params[:course_id]+'/student/'+params[:student_id]+'/grades'
      else
        render 'new' and return
      end 
        
    end
    
     def edit
        @grade  = Grade.find params[:id]
        @course = Course.find params[:course_id]
        @assessmentitems = @course.assessmentitems
     end
    
    def update
     @course = Course.find params[:course_id]
      @assessmentitems = @course.assessmentitems
      @grade = Grade.find params[:id]
      if @grade.update_attributes(permitted_params)
        flash[:notice] = "Grade was successfully updated."
        redirect_to '/courses/' + params[:course_id]+'/student/'+params[:student_id]+'/grades'
      else
        render 'edit' and return
      end
    end 
      
    def destroy
        id = params[:id]
        @grade = Grade.find(id)
        @grade.destroy
        flash[:notice] = "Grade was succesfully deleted!"
        redirect_to '/courses/' + params[:course_id]+'/student/'+params[:student_id]+'/grades'
    end
    
    def permitted_params
        params.require(:grade)
        params[:grade] [:student_id] = params[:student_id]
        params[:grade].permit(:grade, :assessmentitem_id, :student_id)
    end
end