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
    acts_as_taggable

    has_one_attached :file

    belongs_to :ticket

    validate :ensure_file_is_attached

    def ensure_file_is_attached
        if not self.file.attached?
            errors.add(:file, "must be attached")
        end
    end
end
