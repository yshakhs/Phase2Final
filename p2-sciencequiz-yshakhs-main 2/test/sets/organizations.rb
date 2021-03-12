module Contexts
    module Organizations
  
        def create_organizations
        @tamu = FactoryBot.create(:organization) #default organization
        @cornell = FactoryBot.create(:organization, name: "Cornell Medicine", street: "EC street 2" , zip: "33821" ,short_name: "Med" , active: false)
        @cmu = FactoryBot.create(:organization, name: "Carnegie Mellon University", short_name: "CMU" )

        end
        
        def destroy_organizations
        @tamu.destroy
        @cornell.destroy
        @cmu.destroy
        end
  
    end
  end