class Comment < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:comment], using: {
      tsearch: {
          prefix: true,
          highlight: {
              StartSel: '<b>',
              StopSel: '</b>'
          }
      }
  }

  belongs_to :user
  belongs_to :ticket

  validates :comment, presence: true
end
