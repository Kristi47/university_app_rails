Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :courses do
    resources :assessmentitems
  end
  resources :instructors
  resources :students

  root :to => redirect('/welcome')
   
  get    '/welcome',     to: 'sessions#welcome' # it is the welcome page, this is showed to the user when it opens the app
  get    '/instructor_home', to: 'sessions#instructor_home' # this is the instructor homepage
  get    '/student_home', to: 'sessions#student_home' # this is the instructor homepage

  get    '/login',   to: 'sessions#new' # show login page
  post   '/login',   to: 'sessions#create' # when suer clicks login button (submit form)
  post   '/logout',  to: 'sessions#destroy' # logout

  get '/courses/:course_id/index_students' => 'courses#index_students' # show all students for a course
  get '/courses/:course_id/add_student' => 'courses#add_student' # add a studen to a course
  get '/courses/:course_id/remove_student' => 'courses#remove_student' #remove student from course

  # below are the path to perform all CRUD operation os grades
  get  '/courses/:course_id/student/:student_id/grades' => 'grades#index'
  get  '/courses/:course_id/student/:student_id/grades/new' => 'grades#new'
  post  '/courses/:course_id/student/:student_id/grades' => 'grades#create'
  get  '/courses/:course_id/student/:student_id/grades/:id/edit' => 'grades#edit'
  put  '/courses/:course_id/student/:student_id/grades/:id' => 'grades#update'
  delete  '/courses/:course_id/student/:student_id/grades/:id' => 'grades#destroy'
end
