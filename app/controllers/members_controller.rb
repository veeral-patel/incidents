class MembersController < ApplicationController
    before_action :set_incident

    def index
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:incident_id])
    end
end