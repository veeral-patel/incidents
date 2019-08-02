class StatusesController < ApplicationController
  before_action :set_status, only: [:edit, :update, :destroy]
  before_action :authorize_admin

  # GET /admin/statuses
  def index
    @statuses = Status.all
    @status = Status.new
  end

  # GET /admin/statuses/1/edit
  def edit
  end

  # POST /admin/statuses
  def create
    @status = Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to statuses_url, notice: 'Status was successfully created.' }
      else
        format.html { redirect_to statuses_url, alert: "Could not create status. Did you enter the status's name?" }
      end
    end
  end

  # PATCH/PUT /admin/statuses/1
  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to statuses_url, notice: 'Status was successfully updated.' }
      else
        format.html { render :edit, alert: "Could not update status" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:name)
    end

    def authorize_admin
      return unless !current_user.admin?
      redirect_to root_path, alert: 'Admins only!'
    end
end
