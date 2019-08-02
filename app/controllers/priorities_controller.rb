class PrioritiesController < ApplicationController
    before_action :set_priority, only: [:edit]
    before_action :authorize_admin

    # GET /priorities
    def index
        @priorities = Priority.all
    end

    # GET /priorities/1/edit
    def edit
    end

    private
      def authorize_admin
        return unless !current_user.admin?
        redirect_to root_path, alert: 'Admins only!'
      end

      def set_priority
        @priority = Priority.find(params[:id])
      end
end