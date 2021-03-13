require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  #matchers
  should have_many(:students)
  should have_many(:teams)
  should have_many(:student_teams).through(:students)
  should have_many(:student_teams).through(:teams)

  #validations
  should validate_presence_of(:name)
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)
  should validate_presence_of(:short_name)
  should validate_uniqueness_of(:short_name)
  should validate_confirmation_of(:zip)

  should allow_value('Alabama').for(:state)
  should allow_value('AL').for(:state)
  should allow_value('Colorado').for(:state)
  should_not allow_value("colorado").for(:state)
  should_not allow_value('txas').for(:state)
  should_not allow_value(3.14159).for(:state)

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


  # test "the truth" do
  #   assert true
   end #end of context
end
