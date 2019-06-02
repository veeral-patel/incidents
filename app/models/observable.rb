class Observable < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :observable, presence: true
end
