FactoryBot.define do
    factory :team do
      name { "engineer" }
      association :organization
      division { "senior" }
      active { true }
    end
  end