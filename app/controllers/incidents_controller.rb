class IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy, :tickets, :leads, :tree]

  # GET /incidents
  # GET /incidents.json
  def index
    @incidents = Incident.all
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
  end

  # GET /incidents/1/observables
  # GET /incidents/1/observables.json
  def observables
      @incident = Incident.find(params[:id])
      respond_to do |format|
        format.html { render :observables }
        format.json { render json: @incident.observables }
      end
  end

  # GET /incidents/1/attachments
  # GET /incidents/1/attachments.json
  def attachments
    @incident = Incident.find(params[:id])
    respond_to do |format|
      format.html { render :attachments }
      format.json { render json: @incident.attachments }
    end
end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # GET /incidents/1/edit
  def edit
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = current_user.incidents.new(incident_params)

    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
        format.json { render :show, status: :ok, location: @incident }
      else
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /incidents/1/tickets
  # GET /incidents/1/tickets.json
  def tickets
  end

  # GET /incidents/1/leads
  # GET /incidents/1/leads.json
  def leads
  end

    # GET /tickets/1/tree
  # GET /tickets/1/tree.json
  def tree
    gon.push({ incident_tree_as_json: @incident.to_json })

    respond_to do |format|
      format.html { render :tree }
      format.json { render json: @incident.to_json }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incident
      @incident = Incident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:name, :description, :tag_list, :status)
    end
end
