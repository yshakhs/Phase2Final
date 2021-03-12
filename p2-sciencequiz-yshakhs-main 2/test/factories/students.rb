FactoryBot.define do
    factory :student do
      first_name { "Mai" }
      last_name { "Al-shakhs" }
      grade { 5 }
      association :organization
      active { true }
        
    end
  end