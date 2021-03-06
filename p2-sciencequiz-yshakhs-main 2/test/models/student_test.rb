require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  #matchers
  should belong_to(:organization)
  should have_many(:student_teams) 
  should have_many(:teams).through(:student_teams)
  
  #validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:organization_id)
  should validate_presence_of(:grade)                 


  #inclusion of grade resistence
  should allow_value(3).for(:grade)
  should allow_value(12).for(:grade)
  should allow_value(6).for(:grade)
  should_not allow_value('1').for(:grade)
  should_not allow_value(-2).for(:grade)
  should_not allow_value(0).for(:grade)
  should_not allow_value(22).for(:grade)
  should_not allow_value(" ").for(:grade)
  should_not allow_value("seven").for(:grade)

  #context

  context "Given context" do 
    setup do  #creates the students
      create_organizations
      create_students
    end 

    teardown do #destroys them
      destroy_students
      destroy_organizations
    end

    should "have a scope to show active students" do
      assert_equal ["Al-shakhs", "Al-zeyara"], Student.active.alphabetical.map{|t| t.last_name}
    end
    #scope should only return the list of active students sorted by last name

    should "have a scope to show inactive students" do
      assert_equal ["Al-maadeed"], Student.inactive.alphabetical.map{|t| t.last_name}
    end
    #scope should only return the list of inactive students sorted by last name

    should "have a scope to alphabetize teams by last_name and first_name" do
      assert_equal ["Al-maadeed", "Al-shakhs", "Al-zeyara"], Student.alphabetical.map{|t| t.last_name}
    end
    #scope should return the list of students sorted by last and first name if students alphebateically

    should "have name methods that list last_ and first_names combined" do
      assert_equal "Al-shakhs Mai", @student1.name
      assert_equal "Al-zeyara Maha", @student2.name
      assert_equal "Al-maadeed Khawla", @student3.name
    end

    should "have name methods that list first_ and last_names combined" do
      assert_equal "Mai Al-shakhs", @student1.proper_name
      assert_equal "Maha Al-zeyara", @student2.proper_name
      assert_equal "Khawla Al-maadeed", @student3.proper_name
    end

    should "have a method to make inactive" do
      @student2.make_inactive
      assert_equal ["Al-maadeed", "Al-zeyara"], Student.inactive.alphabetical.map{|t| t.last_name}
    end

    should "have a method to make active" do
      @student2.make_active
      assert_equal ["Al-shakhs", "Al-zeyara"], Student.active.alphabetical.map{|t| t.last_name}
    end


    # test the custom validation 'organization_is_active_in_system'
    should "identify a non-active organization as invalid" do
      # using 'build' instead of 'create' so not added to db; org will not be in the system (only in memory)
      @testorg = FactoryBot.build(:organization, name: "VCU", active: 'false')
      studenttest = FactoryBot.build(:student, organization: @testorg)
      deny studenttest.valid?
      # we've created plenty of valid teams earlier, so not testing the validation allows good cases
    end

     end #end of context

end
