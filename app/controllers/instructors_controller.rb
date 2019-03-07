class InstructorsController < ApplicationController
    protect_from_forgery with: :exception

    # get all instructors
    def index
      @instructors = Instructor.all
    end

    # get instructor with specific id
    def show
      id = params[:id]
      @instructor = Instructor.find(id)
      # will render view/instructor/show/html/haml by default
    end

  end
  