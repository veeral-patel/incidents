class Ticket < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name, :description, :tag_list, :user, :status, :priority, :assigned_to, :parent], 
  using: {
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

  has_ancestry
  acts_as_taggable

  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :observables, dependent: :destroy

  belongs_to :incident
  belongs_to :user
  belongs_to :assigned_to, :class_name => 'User', optional: true

  validates :name, presence: true
  validates :status_id, presence: true
  validates :priority_id, presence: true

  def to_s
    self.name
  end

  def status
    Status.find(status_id).name
  end

  def priority
    Priority.find(priority_id).name
  end

  # needed, as we're indexing using the 'status' method on this model
  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end

  def to_json
    if self.is_lead
        name = self.name + " [lead]"
    else
        name = self.name
    end

    if self.children.empty?
      {
        text: { name: name },
        link: { href: Rails.application.routes.url_helpers.ticket_path(self) },
        collapsable: true,
        HTMLclass: self.status,
        HTMLid: self.id,
        connectors: {
            style: {
                'stroke': 'gray',
            }
        },
      }
    else
      {
        text: { name: name },
        link: { href: Rails.application.routes.url_helpers.ticket_path(self) },
        collapsable: true,
        HTMLclass: self.status,
        HTMLid: self.id,
        children: self.children.map { |child| child.to_json },
        connectors: {
            style: {
                'stroke': 'gray',
            }
        },
      }      
    end
  end

  def create_template
    if self.children.empty?
      # create template only for itself
      template = TicketTemplate.create(name: self.name, description: self.description)
      return template
    else
      # create parent template
      parent_template = TicketTemplate.create(name: self.name, description: self.description)

      # create templates for children
      self.children.each do |child|
        child_template = child.create_template
        child_template.parent = parent_template
        child_template.save
      end
      
      return parent_template
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
          MentionMailer.mentioned_in_ticket_description(user, self).deliver_later
      end
    end
end
