FactoryBot.define do
    factory :student_team do
      association :student
      association :team
      start_date { 1.day.ago.to_date }
      end_date { 1.day.from_now.to_date}
      position { 5 }
        active { true }
    end
  end