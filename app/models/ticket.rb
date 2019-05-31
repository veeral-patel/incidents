class Ticket < ApplicationRecord
  validates :name, presence: true

  belongs_to :incident, required: true
end
