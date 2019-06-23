class IncidentPolicy < ApplicationPolicy
    # --- not specific to one incident -----
    def index?
        # anyone can view list of incidents
        true
    end

    def new?
        # anyone can create an incident
        true
    end
    
    def create?
        # anyone can create an incident
        true
    end

    # ---- specific to one incident --------

    def show?
        user.admin? or record.members.include?(user)
    end

    def update?
        show?
    end

    def destroy?
        show?
    end

    def tree?
        show?
    end

    def observables?
        show?
    end

    def attachments?
        show?
    end
    
    def tickets?
        show?
    end

    def leads?
        show?
    end

    def danger?
        show?
    end

    def new_ticket?
        show?
    end
end