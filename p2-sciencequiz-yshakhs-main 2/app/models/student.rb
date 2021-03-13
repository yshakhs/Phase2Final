class Student < ApplicationRecord
  belongs_to :organizations
  has_and_belongs_to_many :teams


  validates_presence_of :, :last_name
  validates_presence_of :organization_id
  validates_presence_of :grade

  validate :organization_is_active_in_system

#  GRADES_List = [3,4,5,6,7,8,9,10,11,12]
#  validates_inclusion_of :grade, in: GRADES_List.map {value}, message: "is not an option", allow_blank: false

  validates :grade, presence: true, numericality: { greater_than: 2, less_than: 13 ,only_integer: true}

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :alphabetical, -> { order('last_name, first_name') }
  
  # joins(:task).order('name')
  #scope :juniors, -> { where(division: 'junior') }
  #scope :seniors, -> { where(division: 'senior') }



  def make_active
    self.active=true
    self.save!
  end
  
        
  def make_inactive
      self.active=false
      self.save!
  end

  def current_team

  end

  def junior?
  end

  def name
    last_name + " " + first_name
  end

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
