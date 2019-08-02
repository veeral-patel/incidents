class Incident < ApplicationRecord
    include PgSearch::Model
    multisearchable against: [:name, :description, :tag_list, :status, :user], using: {
        tsearch: {
            prefix: true,
            highlight: {
                StartSel: '<b>',
                StopSel: '</b>'
            }
        }
    }

    acts_as_taggable

    after_create :add_creator_to_members

    after_create :notify_mentioned_users
    after_update_commit :notify_mentioned_users, if: :saved_change_to_description?

    enum status: { open: 0, in_progress: 1, closed: 2}

    validates :name, presence: true
    validates :status, presence: true

    has_many :tickets, dependent: :destroy
    has_many :observables, through: :tickets
    has_many :attachments, through: :tickets
    has_and_belongs_to_many :members, class_name: "User"

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
            children: root_tickets.map { |ticket| ticket.to_json },
            connectors: {
                style: {
                    'stroke': 'gray',
                }
            },
        }
    end

    private
        def add_creator_to_members
            self.members << self.user
            self.save
        end

        def notify_mentioned_users
            mentions = begin
                regex = /@([\w]+)/
                self.description.scan(regex).flatten    
            end
            mentioned_users = User.where(username: mentions)
            mentioned_users.each do |user|
                MentionMailer.mentioned_in_incident_description(user, self).deliver_later
            end
        end
end
