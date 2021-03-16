require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  #matchers ensures that we have the correct relationships 
  should have_many :students 
  should have_many :teams


  #validations ensures we have the correct validations in our original file
  should validate_presence_of(:name)
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)
  should validate_presence_of(:short_name)
   #makes sure the short_name is unique and case insensitive
  validate_uniqueness_of(:short_name).case_insensitive

  should allow_value('Alabama').for(:state)
  should allow_value('AL').for(:state)
  should allow_value('Colorado').for(:state)
  #makes sure that it allows the correct values and doesnt allow the other wrong values
  should_not allow_value("colorado").for(:state)
  should_not allow_value('txas').for(:state)
  #no numbers allowed in state
  should_not allow_value(3.14159).for(:state)

  #allows a number of 5 numnbers in a string but not letters check
  should allow_value("03431").for(:zip) 
  should_not allow_value("terri").for(:zip)

  #test that the state allowed are in the list below and onlky this list 
  TEST_STATES = ['Alabama', 'AL','Alaska', 'AK','Arizona', 'AZ','Arkansas', 'AR','California', 'CA','Colorado', 'CO','Connectict', 'CT','Delaware', 'DE','District of Columbia ', 'DC','Florida', 'FL','Georgia', 'GA','Hawaii', 'HI','Idaho', 'ID','Illinois', 'IL','Indiana', 'IN','Iowa', 'IA','Kansas', 'KS','Kentucky', 'KY','Louisiana', 'LA','Maine', 'ME','Maryland', 'MD','Massachusetts', 'MA','Michigan', 'MI','Minnesota', 'MN','Mississippi', 'MS','Missouri', 'MO','Montana', 'MT','Nebraska', 'NE','Nevada', 'NV','New Hampshire', 'NH','New Jersey', 'NJ','New Mexico', 'NM','New York', 'NY','North Carolina','NC','North Dakota', 'ND','Ohio', 'OH','Oklahoma', 'OK','Oregon', 'OR','Pennsylvania', 'PA','Rhode Island', 'RI','South Carolina', 'SC','South Dakota', 'SD','Tennessee', 'TN','Texas', 'TX','Utah', 'UT','Vermont', 'VT','Virginia', 'VA','Washington', 'WA','West Virginia', 'WV','Wisconsin ', 'WI','Wyoming', 'WY']
  should validate_inclusion_of(:state).in_array(TEST_STATES).allow_blank



  #context

  context "Given context" do 
    setup do 
      create_organizations #creates the org
    end 

    teardown do
      destroy_organizations #destroys them
    end

    #test scopes, validations, and methods.

    should "scope to return only active organizations" do
     assert_equal ["Carnegie Mellon University", "TAMU" ], Organization.active.map{|o| o.name}.sort
    #scope should only return the list of active organizations sorted by name
    end
    should "scope to return only inactive organizations" do
      assert_equal ["Cornell Medicine"], Organization.inactive.map{|o| o.name}.sort
    #scope should only return the list of inactive organizations sorted by name

    end   
 
    should "have a scope to alphabetize organizations by name" do
      assert_equal ["Carnegie Mellon University", "Cornell Medicine", "TAMU"], Organization.alphabetical.map{|o| o.name}
    #scope should return the list of organizations sorted by name alphebateically

    end

    should "have a method to make inactive" do
      @tamu.make_inactive
      assert_equal ["Cornell Medicine", "TAMU" ], Organization.inactive.map{|o| o.name}.sort
        #this method is making tamu an inactove org and then checking if it is inactive by calling the inactive org list

    end

    should "have a method to make active" do
      @tamu.make_active
      assert_equal ["Carnegie Mellon University", "TAMU" ], Organization.active.map{|o| o.name}.sort
      #this method is making tamu an active org and then checking if it is active by calling the active org list

    end


   end #end of context
end
