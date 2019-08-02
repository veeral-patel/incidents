class Observable < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:observable, :description, :tag_list], using: {
      tsearch: {
          prefix: true,
          highlight: {
              StartSel: '<b>',
              StopSel: '</b>'
          }
      }
  }

  after_create :notify_mentioned_users
  after_update_commit :notify_mentioned_users, if: :saved_change_to_description?

  acts_as_taggable

  belongs_to :user
  belongs_to :ticket

  validates :observable, presence: true

  def to_s
    self.observable
  end

  private
    def notify_mentioned_users
        mentions = begin
            regex = /@([\w]+)/
            self.description.scan(regex).flatten    
        end
        mentioned_users = User.where(username: mentions)
        mentioned_users.each do |user|
            MentionMailer.mentioned_in_observable_description(user, self).deliver_later
        end
    end
end
