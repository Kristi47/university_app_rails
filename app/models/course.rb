class Course < ActiveRecord::Base

    validates :code, :presence => true, :length => {:in => 5..6}
    validates :name, :presence => true, :length => {:maximum => 50}
    validates :semester_offered, :presence => true, :length => {:maximum => 10}
    validates :catalog_data, :length => {:maximum => 500} 

    belongs_to :instructor
    has_many :assessmentitems
    has_and_belongs_to_many :students

    def overall_grade(user)
        overall = 0.0
        partial_res= Hash.new
        result= Hash.new
        self.assessmentitems.each do |assessmentitem|
          assessmentitem.grades.each do |grade|
            if grade.student_id == user.id then
                overall+=grade.grade.to_d*assessmentitem.weight.to_d
                partial_res[:assessment]=assessmentitem.name
                partial_res[:grade]=grade.grade
                result[assessmentitem.id]=partial_res
            end
          end
        end
        result[:overall]=overall
        result 
    end
end