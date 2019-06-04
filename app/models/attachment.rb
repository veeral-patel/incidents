class Attachment < ApplicationRecord
    has_one_attached :file

    belongs_to :ticket
end
