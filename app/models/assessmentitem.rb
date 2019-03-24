class Assessmentitem < ActiveRecord::Base
  
    validates :name, :presence => true, :length => {:maximum => 30}
    validates :weight, :presence => true, :inclusion => {:in => '0.0'..'1.0'}
    
    belongs_to :course
    has_many :grades
 
  
    def max_min_grade
      result = Hash.new
      mygrades = Array.new
      sum = 0.0
      min = 120
      max = 0
      self.grades.each do |current_grade|
        mygrades << current_grade.grade.to_f
        sum += current_grade.grade.to_f
      end
      result[:max] = mygrades.max
      result[:min] = mygrades.min
      result[:avg] = sum/self.grades.size
      result
    end
  end