class StudentTeam < ApplicationRecord
  belongs_to :students
  belongs_to :teams

  validates_date :start_date
  validates_presence_of :position
  validates_presence_of :student_id, :team_i

  validate :student_is_active_in_system
  validate :team_is_active_in_system

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :alphabetical, -> { joins(:student)order( 'last_name, first_name') }
  scope :chronological, -> {  order(start_date: :asc) }
  scope :by_position, -> { order('position') }
 
  scope :captains, -> { order(position) }
 
  scope :for_team, -> (team){ joins(:team).where('name=?', team) }
  scope :for_student, -> (student){ joins(:student).where('first_name=?', student) }
  scope :current, -> { where("end_date >=?",Date.current) }
  scope :past, -> { where("end_date <?", Date.current) }

  def make_active
    self.active=true
    self.save!
  end
  
        
  def make_inactive
      self.active=false
      self.save!
  end

  def end_previous_team_assignment

  end


  private
  def student_is_active_in_system
    # get an array of all active students in the system
    all_student_ids = Student.active.all.map{|s| s.id}
    # add error unless the student id of the team is in the array of active students
    unless  all_student_ids.include?(self.student_id)
      errors.add(:student, "is not an active student in the system")
    end
  end
  
  def team_is_active_in_system
    # get an array of all active teams in the system
    all_team_ids = Team.active.all.map{|t| t.id}
    # add error unless the team id of the team is in the array of active teams
    unless all_team_ids.include?(self.team_id)
      errors.add(:team, "is not an active team in the system")
    end
  end

end
