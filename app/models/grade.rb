class Grade < ActiveRecord::Base
    
    validates :grade, :presence => true, :numericality => {:only_integer => true}
    validates :assessmentitem_id, :presence => true
    validates_uniqueness_of :assessmentitem_id, scope: :student_id
    validates :student_id, :presence => true
    validates_inclusion_of :grade, :in => '1'..'100'

    belongs_to :student
    belongs_to :assessmentitem
 
end