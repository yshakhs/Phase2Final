FactoryBot.define do
    factory :team do
      name { "engineer" }
      association :organization
      division { "Senior" }
      active { true }
    end
  end