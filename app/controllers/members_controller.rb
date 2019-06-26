# remember: after adding an action, add authorization checking code for it
class MembersController < ApplicationController
    before_action :set_incident

    def index
      raise Pundit::NotAuthorizedError unless IncidentPolicy.new(current_user, @incident).show?
    end

    def destroy
      raise Pundit::NotAuthorizedError unless IncidentPolicy.new(current_user, @incident).show?

      if @incident.members.count == 1
        respond_to do |format|
          format.html { redirect_to incident_members_url(@incident), alert: "Cannot remove last member" }
        end
      else
        @member = User.find(params[:id])
        @incident.members.delete(@member)
        respond_to do |format|
          format.html { redirect_to incident_members_url(@incident), notice: 'Member was successfully removed.' }
        end
      end
    end

    private
      def set_incident
        @incident = Incident.find(params[:incident_id])
      end
end
