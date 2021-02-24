class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :grade
      t.references :organization_id, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
