class Ticket < ApplicationRecord
  has_ancestry
  acts_as_taggable

  enum status: { open: 0, in_progress: 1, closed: 2}
  enum priority: { low: 0, medium: 1, high: 2}

  has_many :attachments
  has_many :comments

  belongs_to :incident
  belongs_to :user

  validates :name, presence: true
  validates :status, presence: true
  validates :priority, presence: true
end
