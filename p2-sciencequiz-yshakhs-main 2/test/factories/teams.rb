FactoryBot.define do
    factory :team do
      name { "engineer" }
      association :organization #organization_id foreign key
      division { "senior" }
      active { true }
    end
  end

      #factory bot to create a default teams whenever teams  is created with no values except for the foreign key value