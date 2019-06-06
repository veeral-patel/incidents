class Incident < ApplicationRecord
    acts_as_taggable

    enum status: { open: 0, in_progress: 1, closed: 2}

    validates :name, presence: true
    validates :status, presence: true

    has_many :tickets, dependent: :destroy
    has_many :observables, through: :tickets
    has_many :attachments, through: :tickets

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

    def to_json
        root_tickets = Ticket.where(incident_id: self.id, ancestry: nil)
        {
            text: { name: "root" },
            collapsable: true,
            children: root_tickets.map { |ticket| ticket.to_json }
        }
    end
end
