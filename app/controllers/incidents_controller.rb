# remember: when adding an action, add an action in incident_policy.rb
class IncidentsController < ApplicationController
  # authorize every action
  before_action :authorize_actions_on_one_incident, except: [:index, :assigned_incidents, :create, :new]
  before_action :authorize_other_actions, only: [:index, :assigned_incidents, :create, :new]

  before_action :set_incident, only: [:show, :update, :destroy, :tickets, :leads, :tree, :danger, :new_ticket]

  # verify each action is authorized
  after_action :verify_authorized

  # GET /incidents
  def index
    @title, @empty_message = "Incidents", "No incidents"

    if current_user.admin
      @incidents = Incident.all
    else
      @incidents = current_user.joined_incidents
    end
  end

  # GET /assigned_incidents
  def assigned_incidents
      @incidents = current_user.assigned_incidents
      @title, @empty_message = "Assigned Incidents", "You haven't been assigned any incidents."

      respond_to do |format|
        format.html { render :index }
      end
  end

  # GET /incidents/1
  def show
  end

  # GET /incidents/1/observables
  def observables
      @incident = Incident.find(params[:id])
      respond_to do |format|
        format.html { render :observables }
      end
  end

  # GET /incidents/1/attachments
  # GET /incidents/1/attachments.json
  def attachments
    @incident = Incident.find(params[:id])
    respond_to do |format|
      format.html { render :attachments }
    end
end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = current_user.incidents.new(incident_params)

    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Incident was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /incidents/1
  # PATCH/PUT /incidents/1.json
  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incident was successfully updated.' }
      else
        format.html { render :show }
      end
    end
  end

  # DELETE /incidents/1
  # DELETE /incidents/1.json
  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to incidents_url, notice: 'Incident was successfully destroyed.' }
    end
  end

  # GET /incidents/1/danger
  def danger
  end

  # GET /incidents/1/tickets
  def tickets
  end

  # GET /incidents/1/leads
  def leads
  end

  # GET /tickets/1/tree
  # GET /tickets/1/tree.json
  def tree
    gon.push({
      incident_tree_as_json: @incident.to_json,
      user: {
        username: current_user.username,
        authentication_token: current_user.authentication_token,
      },
      tickets_url: tickets_url
    })

    respond_to do |format|
      format.html { render :tree }
    end
  end

  def new_ticket
    @ticket = Ticket.new

    if current_user.admin 
      if Incident.all.count == 0
        @ticket.errors.add(:base, "No incidents exist! Create an incident before creating a ticket.") 
      end
    else
      if current_user.joined_incidents.count == 0
        @ticket.errors.add(:base, "You are not a member of any incidents. You must create an incident, or be added to one, before creating a ticket.")
      end
    end
  end

  private
    def set_incident
      @incident = Incident.find(params[:id])
    end

    def authorize_actions_on_one_incident
      @incident = Incident.find(params[:id])
      authorize @incident
    end

    def authorize_other_actions
      authorize Incident
    end

    def incident_params
      params.require(:incident).permit(:name, :description, :tag_list, :status_id, :assigned_to_id, :member_ids => [])
    end
end
