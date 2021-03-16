require 'test_helper'

class TeamTest < ActiveSupport::TestCase

#matchers
should belong_to(:organizations)
should have_many(:student_teams) 
should have_many(:students).through(:student_teams)


#validations
should validate_presence_of(:name)
should validate_presence_of(:organization_id)
should validate_presence_of(:division)

#inclusion of division
should allow_value('senior').for(:division)
should allow_value('junior').for(:division)
should_not allow_value("Senior").for(:division)
should_not allow_value('1').for(:division)
should_not allow_value(2).for(:division)

should validate_inclusion_of(:division).in_array(["senior", "junior"])


#context

  context "Given context" do 
    setup do 
      create_organizations
      create_teams
    end 

    teardown do
      destroy_organizations
      destroy_teams
    end

    should "have a scope to show active teams" do
      assert_equal ["engineer", "Team 1"], Team.active.alphabetical.map{|t| t.name}
    end

    should "have a scope to show inactive teams" do
      assert_equal ["Team 2"], Team.inactive.alphabetical.map{|t| t.name}
    end

    should "have a scope to alphabetize teams by name" do
      assert_equal ["engineer", "Team 1", "Team 2"], Team.alphabetical.map{|t| t.name}
    end

    should "have a scope to show only junior divisions by order" do
      assert_equal ["Team 2"], Team.juniors.alphabetical.map{|t| t.name}
    end
    
    should "have a scope to show only senior divisions by order" do
      assert_equal ["engineer", "Team 1"], Team.seniors.alphabetical.map{|t| t.name}
    end

   # should "have a scope to show teams in a specific organization" do
    #  assert_equal ["Mow grass", "Shovel driveway", "Sweep floor", "Wash dishes"], Task.active.alphabetical.map{|t| t.name}
    #end

    # test the custom validation 'organization_is_active_in_system'
    should "identify a non-active organization as invalid" do
      # using 'build' instead of 'create' so not added to db; org will not be in the system (only in memory)
      @testorg = FactoryBot.build(:organization, name: "VCU", active: 'false')
      teamtest = FactoryBot.build(:team, organization: @testorg)
      deny teamtest.valid?
      # we've created plenty of valid teams earlier, so not testing the validation allows good cases
    end
    



     end #end of context
end
