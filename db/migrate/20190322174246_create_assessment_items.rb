class CreateAssessmentItems < ActiveRecord::Migration[5.1]
  def change
    create_table :assessmentitems do |t|
      t.string 'name'
      t.string 'weight'
      t.references  'course'
      t.timestamps
    end
  end
end
