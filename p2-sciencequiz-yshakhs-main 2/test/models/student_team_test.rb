require 'test_helper'

class StudentTeamTest < ActiveSupport::TestCase
   #matchers
   should belong_to(:students)
   should belong_to(:teams)
   
   #validations
   should validate_presence_of(:position)
   should validate_presence_of(:student_id)
   should validate_presence_of(:team_id)

   should allow_value(1.day.from_now.to_date).for(:start_date)
   should allow_value(1.day.ago.to_date).for(:start_date)
   should allow_value(Date.current).for(:start_date)
   should_not allow_value("bad").for(:start_date)
   should_not allow_value(3.14159).for(:start_date)
   
   #inclusion of grade resistence
   should allow_value(3).for(:grade)
   should allow_value(12).for(:grade)
   should allow_value(6).for(:grade)
   should_not allow_value('1').for(:grade)
   should_not allow_value(-2).for(:grade)
   should_not allow_value(0).for(:grade)
   should_not allow_value(22).for(:grade)
   should_not allow_value().for(:grade)
   should_not allow_value(" ").for(:grade)
   should_not allow_value("seven").for(:grade)
 
  #context


  context "Given context" do 
    setup do 
      create_organizations
      create_teams
      create_students
      create_student_teams
    end 

    teardown do
      destroy_organizations
      destroy_students
      destroy_teams
      destroy_student_teams
    end

    should "have a scope to show active student_teams" do
      assert_equal [1, 5], StudentTeam.active.map{|t| t.position}.sort
    end

    should "have a scope to show inactive student_teams" do
      assert_equal [3], StudentTeam.inactive.map{|t| t.position}.sort
    end


    should "have a scope to alphabetize student_teams by student last_ and first_name" do
      assert_equal [3, 5, 1], StudentTeam.alphabetical.map{|t| t.position}
    end

    should "have a scope to chronological student_teams by start_date" do
      assert_equal [5, 1, 3], StudentTeam.chronological.map{|t| t.position}
    end

    should "have a scope to by_position student_teams by positions" do
      assert_equal [1, 3, 5], StudentTeam.by_position.map{|t| t.position}
    end

    # scopes for_team
    # scopes for_student

    should "have a scope for current student_teams" do
      assert_equal 3, StudentTeam.current.size
    end

    should "have a scope for past student_teams" do
      assert_equal 0, StudentTeam.past.size
    end
    

    # test the custom validation 'student_is_active_in_system'
    should "identify a non-active student as invalid" do
      # using 'build' instead of 'create' so not added to db; student_team will not be in the system (only in memory)
      @teststudent = FactoryBot.build(:student, organization: @tamu, first_name: "mike", active: 'false')
      @testtteam = FactoryBot.build(:team, organization: @tamu, name: "Drawing", active: 'true')
      teamstudenttest1 = FactoryBot.build(:student_team, student: @teststudent, team: @testtteam)
      deny teamstudenttest1.valid?
      # we've created plenty of valid teams earlier, so not testing the validation allows good cases
    end
        # test the custom validation 'team_is_active_in_system'
    should "identify a non-active team as invalid" do
      # using 'build' instead of 'create' so not added to db; student_team will not be in the system (only in memory)
      @testteam = FactoryBot.build(:team, organization: @tamu, name: "Arts", active: 'false')
      @teststudents = FactoryBot.build(:student, organization: @tamu, first_name: "Maha", active: 'true')
      teamstudenttest2 = FactoryBot.build(:student_team, student: @teststudents, team: @testteam)
      deny teamstudenttest1.valid?
      # we've created plenty of valid teams earlier, so not testing the validation allows good cases
    end


     end #end of context
end
