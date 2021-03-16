class AddTeamToStudentTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_teams, :team, foreign_key: true
  end
end
