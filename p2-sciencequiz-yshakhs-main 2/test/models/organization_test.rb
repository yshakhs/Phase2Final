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


  #context

  context "Given context" do 
    setup do 
      create_organizations
    end 

    teardown do
      destroy_organizations
    end

    #test scopes, validations, and methods.
  # test "the truth" do
  #   assert true
   end #end of context
end
