class Ticket < ApplicationRecord
  has_ancestry

  enum status: { open: 0, in_progress: 1, closed: 2}
  enum priority: { low: 0, medium: 1, high: 2}

  belongs_to :incident
  belongs_to :user

  validates :name, presence: true
  validates :status, presence: true
  validates :priority, presence: true
end
