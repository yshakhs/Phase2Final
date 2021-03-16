class Organization < ApplicationRecord
    #relationships
    has_many :students
    has_many :teams

    #validations presence of name, street_1, zip, and shourt_name  
    validates_presence_of :name
    validates_presence_of :street_1
    validates_presence_of :zip
    validates_presence_of :short_name
    #scopes to bring out active organizations
    scope :active, -> { where(active: true) }
    #scopes to bring out inactive organizations
    scope :inactive, -> { where(active: false) }
    #scopes to bring out organizations alphebateically
    scope :alphabetical, -> { order('name') }

    #validations for zip format
    validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: false
    #validations for uniquiness of short name and ensuring that its not case sensitive
    validates_uniqueness_of :short_name, message:"short_name already in the records", allow_blank: false, case_insensitive: true

    #US state array which is what the states that are entered must be from and no other values.
    STATES_LIST = ['Alabama', 'AL','Alaska', 'AK','Arizona', 'AZ','Arkansas', 'AR','California', 'CA','Colorado', 'CO','Connectict', 'CT','Delaware', 'DE','District of Columbia ', 'DC','Florida', 'FL','Georgia', 'GA','Hawaii', 'HI','Idaho', 'ID','Illinois', 'IL','Indiana', 'IN','Iowa', 'IA','Kansas', 'KS','Kentucky', 'KY','Louisiana', 'LA','Maine', 'ME','Maryland', 'MD','Massachusetts', 'MA','Michigan', 'MI','Minnesota', 'MN','Mississippi', 'MS','Missouri', 'MO','Montana', 'MT','Nebraska', 'NE','Nevada', 'NV','New Hampshire', 'NH','New Jersey', 'NJ','New Mexico', 'NM','New York', 'NY','North Carolina','NC','North Dakota', 'ND','Ohio', 'OH','Oklahoma', 'OK','Oregon', 'OR','Pennsylvania', 'PA','Rhode Island', 'RI','South Carolina', 'SC','South Dakota', 'SD','Tennessee', 'TN','Texas', 'TX','Utah', 'UT','Vermont', 'VT','Virginia', 'VA','Washington', 'WA','West Virginia', 'WV','Wisconsin ', 'WI','Wyoming', 'WY']
    validates_inclusion_of :state, in: STATES_LIST, message: "is not an option", allow_blank: true

    #funtion to turn and inactive organziation to an active one 
    def make_active
  self.active=true
  self.save!
end

    #funtion to turn and active organziation to an inactive one      
def make_inactive
    self.active=false
    self.save!
end

end
