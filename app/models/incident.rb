class Incident < ApplicationRecord
    acts_as_taggable

    validates :name, presence: true
    has_many :tickets, dependent: :destroy
    belongs_to :user

    def leads
        self.tickets.where(is_lead: true)
    end

    def open_tickets
        self.tickets.where(status: :open)
    end
    
    def in_progress_tickets
        self.tickets.where(status: :in_progress)
    end

    def closed_tickets
        self.tickets.where(status: :closed)
    end

    def to_s
        self.name
    end
end
