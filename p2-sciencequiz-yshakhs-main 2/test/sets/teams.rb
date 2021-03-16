module Contexts
    module Teams
  
        def create_teams
            @team1 = FactoryBot.create(:team, organization: @tamu) #default team
            @team2 = FactoryBot.create(:team, name: "Team 1", organization: @tamu , division: "senior" , active: true )
            @team3 = FactoryBot.create(:team, name: "Team 2", organization: @cmu , division: "junior" , active: false )

        end
        
        def destroy_teams
            @team1.destroy
            @team2.destroy
            @team3.destroy
        end
    
    end
  end