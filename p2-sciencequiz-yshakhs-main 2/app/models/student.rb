class Student < ApplicationRecord
      #relationships
  belongs_to :organization
  has_many :student_teams
  has_many :teams, through: :student_teams

  #validations presence of names, organization id, grade
  validates_presence_of :first_name, :last_name
  validates_presence_of :organization_id
  validates_presence_of :grade

  #validation of the fuction that check if organization id given is of a active 
#or inactive organization and show an error if they are trying to add a 
#sstudenr with a organization that is inactive 
  validate :organization_is_active_in_system

#validate grade as an integer, and between 3 and 12 only
  validates :grade, presence: true, numericality: { greater_than: 2, less_than: 13 ,only_integer: true}
    #scopes to bring out record list of active, inactive students
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  #scopes to bring out list of all students alphebateically by their student last and first_name

  scope :alphabetical, -> { order('last_name, first_name') }
  
  # joins(:task).order('name')
  #scope :juniors, -> { where(division: 'junior') }
  #scope :seniors, -> { where(division: 'senior') }
#couldn't figure out the above.

    #funtion to turn and inactive student to an active one 
  def make_active
    self.active=true
    self.save!
  end
  
       #funtion to turn and active student to an inactive one      
  def make_inactive
      self.active=false
      self.save!
  end

  def current_team

  end
 
  def junior?
    
  end

  #fuction to return  a list of the last name and first name of students as one 
  def name
    last_name + " " + first_name
  end

  #fuction to return a list of the the first name and last name of students as one 
  def proper_name
    first_name + " " + last_name
  end
  
  private
  def organization_is_active_in_system
    # get an array of all active organizations in the system
    all_org_ids = Organization.active.all.map{|o| o.id}
    # add error unless the organization id of the team is in the array of active organizations
    unless all_org_ids.include?(self.organization_id)
      errors.add(:organization, "is not an active organization in the system")
    end
  end

end
