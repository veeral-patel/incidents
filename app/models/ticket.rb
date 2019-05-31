class Ticket < ApplicationRecord
  enum status: { open: 0, in_progress: 1, closed: 2}
  belongs_to :incident, required: true

  validates :name, presence: true
  validates :status, presence: true
end
