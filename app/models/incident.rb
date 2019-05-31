class Incident < ApplicationRecord
    validates :name, presence: true
    has_many :tickets

    def leads
        self.tickets.where(is_lead: false)
    end

    def to_s
        self.name
    end
end
