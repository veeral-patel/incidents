class StatusesController < ApplicationController
  before_action :set_status, only: [:edit, :update, :destroy]
  before_action :authorize_admin

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all
    @status = Status.new
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to statuses_url, notice: 'Status was successfully created.' }
        format.json { render :index, status: :created, location: @status }
      else
        format.html { redirect_to statuses_url, alert: "Could not create status. Did you enter the status's name?" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to statuses_url, notice: 'Status was successfully updated.' }
        format.json { render :index, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
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
