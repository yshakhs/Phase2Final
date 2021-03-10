class Task < ApplicationRecord
    has_many :chores
has_many :children, through: :chores

validates_presence_of :name
validates :points, presence: true, numericality: { greater_than: 0, less_than: 101 ,only_integer: true}


scope :alphabetical, -> { order('name') }
scope :active, -> { where(active: true) }

end
