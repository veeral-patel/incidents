class MembersController < ApplicationController
    before_action :set_incident

    def index
    end

    def destroy
      # FILL IN
    end

    private
      def set_incident
        @incident = Incident.find(params[:incident_id])
      end
end