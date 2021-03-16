class RemoveTeamIdIdFromStudentTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_teams, :team_id_id, :integer
  end
end
