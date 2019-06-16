class AttachmentPolicy < ApplicationPolicy
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