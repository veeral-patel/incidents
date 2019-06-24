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
            }
        else
            {
                text: { name: self.name },
                children: self.children.map { |child| child.to_json },
            }
        end
    end

    def to_s
        self.name
    end
end
