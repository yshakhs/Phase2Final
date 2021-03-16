class StudentTeam < ApplicationRecord
   #relationships
  belongs_to :student
  belongs_to :team

    #validations of start dates to not exceed todays date but could have started earlier  
  validates_date :start_date, on_or_before: -> {Date.current}
  #validation of prescence of position, student_id, team_id, 
  validates_presence_of :position
  validates_presence_of :student_id, :team_id
  #validation of position to now be above or below the 5 rank and the 1st rank
  validates :position, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

#validation of the fuction that check if student_id given is of a active 
#or inactive student and show an error if they are trying to add a 
#student team with a student that is inactive 
  validate :student_is_active_in_system
  #validation of the fuction that check if team_id given is of a active 
#or inactive team and show an error if they are trying to add a 
#student team with a team that is inactive 
  validate :team_is_active_in_system

    #scopes to bring out active student_team
  scope :active, -> { where(active: true) }
      #scopes to bring out inactive student_team
  scope :inactive, -> { where(active: false) }
      #scopes to bring out student_teams alphebateically by their student last and first_name
  scope :alphabetical, -> { joins(:student).order( 'last_name, first_name') }
        #scopes to bring out student_teams chronologically by their starting date
  scope :chronological, -> {  order(start_date: :asc) }
        #scopes to bring out student_teams in order of their position
  scope :by_position, -> { order('position') }
#returns all the student teams for a given team 
   scope :for_team, -> (team){ joins(:team).where('team_id=?', team) }
#returns all the student teams for a given student 
   scope :for_student, -> (student){ joins(:student).where('student_id=?', student) }
  #returns all the current student-team assignments that havent been done yet
   scope :current, -> { where("end_date >=?",Date.current) }
  # returns all the past student-team assignments
  scope :past, -> { where("end_date <?", Date.current) }
  #captains returns only records for the #1 ranked member of each team
  scope :captains, -> { where(position: 1) }


    #funtion to turn and inactive studentteam to an active one 
  def make_active
    self.active=true
    self.save!
  end
  
  #funtion to turn and active stduenrteam to an inactive one  
  def make_inactive
      self.active=false
      self.save!
  end

   
  # Callback (to handle in sqlite what we would have done in a postrges trigger)
 # before_create :set_end_date_of_old_cost
 #couldn't figure it out

  private

  #callbacks
 def end_previous_team_assignment
#  previous = StudentTeam.current.for_procedure(self.procedure_id).take
 end


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
