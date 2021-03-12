FactoryBot.define do
    factory :organization do
      name { "TAMU" }
      street_1 { "EC street1" }
      street_2 { "maroon-red rusty building" }
      city { "Houstan" }
      state { "Texas" }
      zip { "77449" }
      short_name { "TAMU" }
      active { true }
    end
  end