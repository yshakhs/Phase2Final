class Team < ApplicationRecord
        #relationships
  belongs_to :organization
  has_many :student_teams
  has_many :students, through: :student_teams
  #validations presence of names, organization id, grade
  validates_presence_of :name
  validates_presence_of :organization_id
  validates_presence_of :division
# validation that only junior and senior divisoons can be allowed and not any other value
  Division = ['junior', 'senior']
  validates_inclusion_of :division, in: Division, message: "is not an option", allow_blank: false
#validation of the fuction that check if organization id given is of a active 
#or inactive organization and show an error if they are trying to add a 
#team with a organization that is inactive 
  validate :organization_is_active_in_system

  #returns all the teams for a given organization 
  scope :for_organization, -> (organization) { joins(:organization).where('organization_id =?', organization) 
    #scopes to bring out record list of active, inactive teams
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
    #scopes to bring out a list of all teams alphebateically by their team 

  scope :alphabetical, -> { order('name') }
  #only teams who are in the junior division are returened
  scope :juniors, -> { where(division: 'junior') }
    #only teams who are in the senior division are returened
  scope :seniors, -> { where(division: 'senior') }

      #funtion to turn and inactive team to an active one 
  def make_active
    self.active=true
    self.save!
  end
  
 #funtion to turn and active team to an inactive one 
 
  def make_inactive
      self.active=false
      self.save!
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
