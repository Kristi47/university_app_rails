class CreateGrades < ActiveRecord::Migration[5.1]
  def change
    create_table 'grades' do |t|
      t.string 'grade'
      t.references 'assessmentitem'
      t.references 'student'
      t.timestamps
    end
  end
end