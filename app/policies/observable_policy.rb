class ObservablePolicy < ApplicationPolicy
    # not specific to one observable ---
    def index?
        true
    end

    def new?
        true
    end

    def create?
        true
    end

    # specific to one observable -----
    def show?
        # can show a comment if you can show its ticket
        TicketPolicy.new(@user, record.ticket).show?
    end

    def update?
        show?        
    end

    def destroy?
        show?
    end
end