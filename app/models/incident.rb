class Incident < ApplicationRecord
    validates :name, presence: true
    has_many :tickets
    belongs_to :user

    def leads
        self.tickets.where(is_lead: true)
    end

    def to_s
        self.name
    end
end
