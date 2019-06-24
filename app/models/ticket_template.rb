class TicketTemplate < ApplicationRecord
    has_ancestry

    validates :name, presence: true

    def self.root_templates
        root_templates = []
        TicketTemplate.all.each { |template| root_templates << template if not template.has_parent? }
        root_templates
    end

    def num_tickets
        self.descendants.count + 1
    end

    def to_json
        if self.children.empty?
            {
                text: { name: self.name },
                link: { href: Rails.application.routes.url_helpers.edit_ticket_template_path(self) }
            }
        else
            {
                text: { name: self.name },
                link: { href: Rails.application.routes.url_helpers.edit_ticket_template_path(self) },
                children: self.children.map { |child| child.to_json },
            }
        end
    end

    def to_s
        self.name
    end
end
