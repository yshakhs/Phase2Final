FactoryBot.define do
    factory :student_team do
      association :student #student_id foreign key
      association :team #team_id foreign key
      start_date { 1.day.ago.to_date }
      end_date { 1.day.from_now.to_date}
      position { 5 }
        active { true }
    end
  end

    #factory bot to create a default student team whenever student team is created with no values except for the foreign key values