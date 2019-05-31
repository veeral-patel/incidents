class Ticket < ApplicationRecord
  enum status: { low: 0, medium: 1, high: 2}
  belongs_to :incident, required: true

  validates :name, presence: true
  validates :status, presence: true
end
