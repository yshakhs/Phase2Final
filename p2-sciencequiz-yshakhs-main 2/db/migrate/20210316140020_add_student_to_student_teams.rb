class AddStudentToStudentTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_teams, :student, foreign_key: true
  end
end
