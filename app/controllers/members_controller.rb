class MembersController < ApplicationController
    before_action :set_incident

    def index
    end

    def destroy
      @member = User.find(params[:id])
      @incident.members.delete(@member)
      respond_to do |format|
        format.html { redirect_to incident_members_url, notice: 'Member was successfully removed.' }
      end
    end

    private
      def set_incident
        @incident = Incident.find(params[:incident_id])
      end
end