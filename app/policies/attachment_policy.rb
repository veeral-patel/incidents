class AttachmentPolicy < ApplicationPolicy
    # not specific to one attachment ---
    def index?
        true
    end

    def new?
        true
    end

    def create?
        true
    end

    # specific to one attachment ------
    def show?
        # can show an attachment if you can show its ticket
        TicketPolicy.new(@user, record.ticket).show?
    end

    def update?
        show?
    end

    def destroy?
        show?
    end
end