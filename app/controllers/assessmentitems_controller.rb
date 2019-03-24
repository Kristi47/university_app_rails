class AssessmentitemsController < ApplicationController


	before_action :has_user_and_course, except: [:index]
	before_action :enforce_login_instructor,  except: [:index]
	
	
	protected
	def has_user_and_course
		unless @current_user
			flash[:warning] = 'Login to create an assessment item.'
			redirect_to '/login'
		end
		unless ( @course = Course.find(params[:course_id]) )
			flash[:warning] = 'Assessment Item must be for an existing course.'
			redirect_to courses_path
		end
	end

	private
	def assessmentitem_params
		params.require(:assessmentitem)
		params[:assessmentitem].permit(:name,:weight,:course_id)        
	end
	


	 public
	def index
		@course = Course.find_by_id(params[:course_id])
		@assessmentitems = Assessmentitem.where(:course_id => params[:course_id] )
	end

	public
	def new
		@assessmentitem = @course.assessmentitems.build
	end
	
	def create
		@assessmentitem = @course.assessmentitems.create(assessmentitem_params)
		if @assessmentitem.save
			flash[:notice] = "Assessment item was successfully created."
			redirect_to course_assessmentitems_path(@course)
		else
			render 'new' and return
		end 
	end
	
	def destroy
		id = params[:id]
		@assessmentitem = Assessmentitem.find(id)
		@assessmentitem.destroy
		flash[:warning] = "#{@assessmentitem.name} was succesfully deleted!"
		redirect_to course_assessmentitems_path(@course)
	end
	

	def edit
		@assessmentitem = Assessmentitem.find params[:id]
	end
	

	def update
		@assessmentitem = Assessmentitem.find params[:id]
		if @assessmentitem.update_attributes(permitted_params)
			flash[:notice] = "#{@assessmentitem.name} was successfully updated."
			redirect_to course_assessmentitems_path(@course)
		else
			render 'edit' and return
		end
	end
	
	
	
	 def permitted_params
		params.require(:assessmentitem)
		params[:assessmentitem] [:course_id] = @course.id
		params[:assessmentitem].permit(:name, :weight, :course_id)
	 end
end