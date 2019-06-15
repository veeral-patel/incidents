class IncidentPolicy < ApplicationPolicy
    # --- not specific to one incident -----
    def index?
        true
    end

    def new?
        true
    end
    
    def create?
        true
    end

    # ---- specific to one incident --------

    def show?
        user.admin? or record.members.include?(user)
    end

    def update?
        show?
    end

    def destroy
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
end