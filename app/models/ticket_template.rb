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

    def to_s
        self.name
    end
end
