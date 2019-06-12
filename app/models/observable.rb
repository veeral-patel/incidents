class Observable < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  belongs_to :ticket

  validates :observable, presence: true
end
