class IncidentPolicy < ApplicationPolicy
    def show?
        user.admin? or record.members.include?(user)
    end
end