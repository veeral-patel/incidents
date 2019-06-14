class Ticket < ApplicationRecord
  has_ancestry
  acts_as_taggable

  enum status: { open: 0, in_progress: 1, closed: 2}
  enum priority: { low: 0, medium: 1, high: 2}

  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :observables, dependent: :destroy

  belongs_to :incident
  belongs_to :user
  belongs_to :assigned_to, :class_name => 'User', optional: true

  validates :name, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  def to_s
    self.name
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
      }
    else
      {
        text: { name: name },
        link: { href: Rails.application.routes.url_helpers.ticket_path(self) },
        collapsable: true,
        HTMLclass: self.status,
        HTMLid: self.id,
        children: self.children.map { |child| child.to_json },
      }      
    end
  end
end
