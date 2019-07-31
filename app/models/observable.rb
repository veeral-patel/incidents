class Observable < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:observable], using: {
      tsearch: {
          prefix: true,
          highlight: {
              StartSel: '<b>',
              StopSel: '</b>'
          }
      }
  }

  acts_as_taggable

  belongs_to :user
  belongs_to :ticket

  validates :observable, presence: true
end
