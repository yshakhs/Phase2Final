class RemoveStudentIdIdFromStudentTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_teams, :student_id_id, :integer
  end
end
