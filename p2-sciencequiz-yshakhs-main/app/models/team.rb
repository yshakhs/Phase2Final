class Team < ApplicationRecord
  belongs_to :organization_id
  has_and_belongs_to_many :teams
end
