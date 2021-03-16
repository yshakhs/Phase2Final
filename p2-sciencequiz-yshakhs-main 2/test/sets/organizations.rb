module Contexts
    module Organizations
  
        def create_organizations
            @tamu = FactoryBot.create(:organization) #default organization
            @cornell = FactoryBot.create(:organization, name: "Cornell Medicine", street_1: "EC street 2" , street_2: "EC street 2" , city: "fil", state: "Arizona",  zip: "33821" ,short_name: "WCMC" , active: false)
            @cmu = FactoryBot.create(:organization, name: "Carnegie Mellon University", street_1: "EC street 2" , street_2: "EC street 2" , city: "met", state:"Arkansas", zip: "33021" , short_name: "CMU", active: true )

        end
        
        def destroy_organizations
            @tamu.destroy #destoy organizations record
            @cornell.destroy
            @cmu.destroy
        end
  
    end
  end