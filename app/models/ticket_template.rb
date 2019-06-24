class TicketTemplate < ApplicationRecord
    has_ancestry

    validates :name, presence: true
end
