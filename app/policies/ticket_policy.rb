class TicketPolicy < ApplicationPolicy
    def show?
        # can show a ticket iff you can show its incident
        IncidentPolicy.new(@user, record.incident).show?
    end

    def update?
        show?
    end

    def destroy?
        show?
    end

    def children?
        show?
    end

    def tree?
        show?
    end

    def create_template?
        show?
    end
end