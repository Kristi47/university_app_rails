Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :instructors

  root :to => redirect('/welcome')
   
  get    '/welcome',     to: 'sessions#welcome' # it is the welcome page, this is showed to the user when it opens the app
  get    '/instructor_home', to: 'sessions#instructor_home' # this is the instructor homepage
  get    '/student_home', to: 'sessions#student_home' # this is the instructor homepage

  get    '/login',   to: 'sessions#new' # show login page
  post   '/login',   to: 'sessions#create' # when suer clicks login button (submit form)
  delete '/logout',  to: 'sessions#destroy' # logout
end
