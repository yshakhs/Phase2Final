require 'test_helper'

class StudentTeamTest < ActiveSupport::TestCase
   #matchers

  #context


  context "Given context" do 
    setup do 
      create_teams
    end 

    teardown do
      destroy_teams
    end



     end #end of context
end
