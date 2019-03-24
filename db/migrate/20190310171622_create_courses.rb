class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |course|
      course.string 'code'
      course.string 'name'
      course.string 'semester_offered'
      course.text 'catalog_data'
      course.belongs_to :instructor, index: true 
      course.timestamps
    end
  end
end
