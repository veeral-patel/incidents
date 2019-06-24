# remember - when adding an action, add a corresponding
# method in ticket_policy.rb
class TicketsController < ApplicationController
  # authorize each action
  before_action :authorize_actions_on_one_ticket, except: [:index, :create, :new]

  before_action :set_ticket, only: [:show, :update, :destroy, :children, :tree]

  # verify each action is authorized
  after_action :verify_authorized, except: [:index, :new, :create]

  # GET /tickets
  # GET /tickets.json
  def index
    if current_user.admin
      @tickets = Ticket.all
    else
      @tickets = current_user.joined_tickets
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
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

  # POST /tickets
  # POST /tickets.json
  def create
    # if you can't view an incident, you can't create tickets in it
    incident = Incident.find(ticket_params[:incident_id])
    raise Pundit::NotAuthorizedError unless IncidentPolicy.new(current_user, incident).show?

    @ticket = current_user.tickets.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :show }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # GET /tickets/1/children
  # GET /tickets/1/children.json
  def children
      respond_to do |format|
        format.html { render :children }
        format.json { render json: @ticket.children }
      end
  end

  # GET /tickets/1/tree
  # GET /tickets/1/tree.json
  def tree
    gon.push({ ticket_tree_as_json: @ticket.to_json })

    respond_to do |format|
      format.html { render :tree }
      format.json { render json: @ticket.to_json }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
      @incident = @ticket.incident
    end

    def authorize_actions_on_one_ticket
      @ticket = Ticket.find(params[:id])
      authorize @ticket
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :description, :incident_id, :is_lead, :status, :priority, :tag_list, :parent_id, :assigned_to_id)
    end
end
