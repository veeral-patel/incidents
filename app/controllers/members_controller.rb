# remember: after adding an action, add authorization checking code for it
class MembersController < ApplicationController
    before_action :set_incident

    def index
      raise Pundit::NotAuthorizedError unless IncidentPolicy.new(current_user, @incident).show?
      @nonmembers = User.all - @incident.members
    end

    def create
      if params.key? 'username'
        @member = User.where(username: params['username']).take
      else
        flash[:alert] = "You must specify the username of the member to add"
        redirect_to incident_members_url(@incident) and return
      end
      
      if @member && @incident.members << @member
        flash[:notice] = "Added #{@member.username} to the incident"
        redirect_to incident_members_url(@incident)
        IncidentMailer.added_to_incident(@member, @incident).deliver_later
      else
        flash[:alert] = "Failed to add member to the incident"
        redirect_to incident_members_url(@incident)
      end
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
          format.html { redirect_to incident_members_url(@incident), notice: "Removed #{@member} from the incident" }
        end
      end
    end

    private
      def set_incident
        @incident = Incident.find(params[:incident_id])
      end
end
