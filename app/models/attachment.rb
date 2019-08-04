class Attachment < ApplicationRecord
    include PgSearch::Model
    multisearchable against: [:description, :tag_list], using: {
        tsearch: {
            prefix: true,
            highlight: {
                StartSel: '<b>',
                StopSel: '</b>'
            }
        }
    }

    audited

    after_create :notify_mentioned_users
    after_update_commit :notify_mentioned_users, if: :saved_change_to_description?

    acts_as_taggable

    has_one_attached :file

    belongs_to :ticket

    validate :ensure_file_is_attached

    def to_s
        self.file.blob.filename
    end

    def ensure_file_is_attached
        if not self.file.attached?
            errors.add(:file, "must be attached")
        end
    end

    private
        def notify_mentioned_users
            mentions = begin
                regex = /@([\w]+)/
                self.description.scan(regex).flatten    
            end
            mentioned_users = User.where(username: mentions)
            mentioned_users.each do |user|
                MentionMailer.mentioned_in_attachment_description(user, self).deliver_later
            end
        end
end
