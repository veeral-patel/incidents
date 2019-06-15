class TicketPolicy < ApplicationPolicy
    # not specific to one ticket ------
    def index?
        true
    end

    def new?
        true
    end

    def create?
        true
    end

    # specific to one ticket -------
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
end