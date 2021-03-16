FactoryBot.define do
    factory :student do
      first_name { "Mai" }
      last_name { "Al-shakhs" }
      grade { 5 }
      association :organization #organization_id foreign key
      active { true }
        
    end
  end

    #factory bot to create a default student whenever student  is created with no values except for the foreign key value