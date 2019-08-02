class PrioritiesController < ApplicationController
    before_action :set_priority, only: [:edit, :update, :status]
    before_action :authorize_admin

    # GET /admin/priorities
    def index
        @priorities = Priority.all
    end

    # GET /admin/priorities/1/edit
    def edit
    end

    # PATCH/PUT /admin/priorities/1
    def update
      respond_to do |format|
        if @priority.update(priority_params)
          format.html { redirect_to priorities_url, notice: 'Priority was successfully updated' }
        else
          format.html { render :edit, alert: "Could not update priority"}
        end
      end
    end

    private
      def authorize_admin
        return unless !current_user.admin?
        redirect_to root_path, alert: 'Admins only!'
      end

      def priority_params
        params.require(:priority).permit(:name)
      end

      def set_priority
        @priority = Priority.find(params[:id])
      end
end