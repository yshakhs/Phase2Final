class Organization < ApplicationRecord
    has_many :students
    has_many :teams
end
