require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  #matchers
  should have_many(:students)
  should have_many(:teams)


  #validations
  should validate_presence_of(:name)
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)
  should validate_presence_of(:short_name)
  validate_uniqueness_of(:short_name).case_insensitive
 # should validate_confirmation_of(:zip)

  should allow_value('Alabama').for(:state)
  should allow_value('AL').for(:state)
  should allow_value('Colorado').for(:state)
  should_not allow_value("colorado").for(:state)
  should_not allow_value('txas').for(:state)
  should_not allow_value(3.14159).for(:state)

  should allow_value("03431").for(:zip) 
  should_not allow_value("terri").for(:zip)

  TEST_STATES = ['Alabama', 'AL','Alaska', 'AK','Arizona', 'AZ','Arkansas', 'AR','California', 'CA','Colorado', 'CO','Connectict', 'CT','Delaware', 'DE','District of Columbia ', 'DC','Florida', 'FL','Georgia', 'GA','Hawaii', 'HI','Idaho', 'ID','Illinois', 'IL','Indiana', 'IN','Iowa', 'IA','Kansas', 'KS','Kentucky', 'KY','Louisiana', 'LA','Maine', 'ME','Maryland', 'MD','Massachusetts', 'MA','Michigan', 'MI','Minnesota', 'MN','Mississippi', 'MS','Missouri', 'MO','Montana', 'MT','Nebraska', 'NE','Nevada', 'NV','New Hampshire', 'NH','New Jersey', 'NJ','New Mexico', 'NM','New York', 'NY','North Carolina','NC','North Dakota', 'ND','Ohio', 'OH','Oklahoma', 'OK','Oregon', 'OR','Pennsylvania', 'PA','Rhode Island', 'RI','South Carolina', 'SC','South Dakota', 'SD','Tennessee', 'TN','Texas', 'TX','Utah', 'UT','Vermont', 'VT','Virginia', 'VA','Washington', 'WA','West Virginia', 'WV','Wisconsin ', 'WI','Wyoming', 'WY']
  should validate_inclusion_of(:state).in_array(TEST_STATES).allow_blank



  #context

  context "Given context" do 
    setup do 
      create_organizations
    end 

    teardown do
      destroy_organizations
    end

    #test scopes, validations, and methods.

    should "scope to return only active organizations" do
      assert_equal ["Carnegie Mellon University", "TAMU" ], Organization.active.map{|o| o.name}.sort
    end
    should "scope to return only inactive organizations" do
      assert_equal ["Cornell Medicine"], Organization.inactive.map{|o| o.name}.sort
    end   
 
    should "have a scope to alphabetize organizations by name" do
      assert_equal ["Carnegie Mellon University", "Cornell Medicine", "TAMU"], Organization.alphabetical.map{|o| o.name}
    end


   end #end of context
end
