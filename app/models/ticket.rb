class Ticket < ApplicationRecord
  enum status: { open: 0, in_progress: 1, closed: 2}
  enum priority: { low: 0, medium: 1, high: 2}

  belongs_to :incident, required: true

  validates :name, presence: true
  validates :status, presence: true
  validates :priority, presence: true
end
