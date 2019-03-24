class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string 'firstname'
      t.string 'lastname'
      t.string 'email'
      t.string 'password'
      t.timestamps
    end
  end
end
