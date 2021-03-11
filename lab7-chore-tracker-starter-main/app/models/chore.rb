class Chore < ApplicationRecord

    belongs_to :child 
belongs_to :task

validates_date :due_on


scope :chronological, -> { order(due_on: :asc).order(:completed) }

scope :by_task, -> { joins(:task).order('name') }

scope :pending, -> { where(completed: false) }
scope :done, -> { where(completed: true)}
scope :upcoming, -> { where("due_on >=?",Date.current) }
scope :past, -> { where("due_on <?", Date.current) }

scope :status, ->(id) { where("animal_id = ?", id) }


def status
    return "Completed" if self.completed
    "Pending"
  end

def points_earned
    self.chores.done.inject(0){|sum,chore| sum += chore.task.points}
  end 

end
