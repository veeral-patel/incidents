class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :comment, presence: true
end
