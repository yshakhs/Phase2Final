require './test/sets/organizations'
require './test/sets/teams'
require './test/sets/students'
require './test/sets/student_teams'

module Contexts

    include Contexts::Organizations
    include Contexts::Teams
    include Contexts::Students
    include Contexts::Student_Teams

    def create_all
        create_organizations
        puts "built organizations"

        create_teams
        puts "built teams"

        create_students
        puts "built students"
        
        create_student_teams
        puts "built student teams"
    end


end
