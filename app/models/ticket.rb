class Ticket < ApplicationRecord
  has_ancestry
  acts_as_taggable

  enum status: { open: 0, in_progress: 1, closed: 2}
  enum priority: { low: 0, medium: 1, high: 2}

  has_many :attachments
  has_many :comments
  has_many :observables

  belongs_to :incident
  belongs_to :user

  validates :name, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  def to_s
    self.name
  end

  def to_json
    if self.children.empty?
      {
        text: { name: self.name },
        link: { href: Rails.application.routes.url_helpers.ticket_path(self) },
        collapsable: true
      }
    else
      {
        text: { name: self.name },
        link: { href: Rails.application.routes.url_helpers.ticket_path(self) },
        collapsable: true,
        children: self.children.map { |child| child.to_json }
      }      
    end
  end
end