class StudentTeam < ApplicationRecord
  belongs_to :student_id
  belongs_to :team_id
end
