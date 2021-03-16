module Contexts
    module Student_Teams
  
        def create_student_teams
            @studentTeam1 = FactoryBot.create(:student_team, student: @student1, team: @team1) #default student_team
            @studentTeam2 = FactoryBot.create(:student_team, student: @student2, team: @team2, start_date: 1.day.ago.to_date, end_date: 1.day.from_now.to_date , position: 1 , active: true )
            @studentTeam3 = FactoryBot.create(:student_team, student: @student2, team: @team2, start_date: 1.day.ago.to_date, end_date: Date.current, position: 3, active: false )
        end
        
        def destroy_student_teams
            @studentTeam1.destroy
            @studentTeam2.destroy
            @studentTeam3.destroy
        end
  
    end
  end