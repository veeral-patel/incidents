class TicketsController < ApplicationController
  # authorize each action
  before_action :authorize_actions_on_one_ticket, except: [:index, :create, :assigned_tickets]

  before_action :set_ticket, only: [:show, :update, :destroy, :children, :tree]

  # verify each action is authorized
  after_action :verify_authorized, except: [:index, :create, :assigned_tickets]

  # GET /tickets
  def index
    @tickets = current_user.accessible_tickets
  end

  # GET /assigned_tickets
  def assigned_tickets
    @assigned_tickets = current_user.assigned_tickets
  end

  # GET /tickets/1
  def show
  end

  # POST /tickets
  def create
    # if you can't view an incident, you can't create tickets in it
    @incident = Incident.find(ticket_params[:incident_id])
    raise Pundit::NotAuthorizedError unless IncidentPolicy.new(current_user, @incident).show?

    @ticket = current_user.tickets.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
      else
        format.html { render 'incidents/new_ticket' }
      end
    end
  end

  # PATCH/PUT /tickets/1
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
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
    end
  end
  
  # GET /tickets/1/children
  def children
      respond_to do |format|
        format.html { render :children }
      end
  end

  # GET /tickets/1/tree
  def tree
    gon.push({ ticket_tree_as_json: @ticket.to_json })

    respond_to do |format|
      format.html { render :tree }
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
      @incident = @ticket.incident
    end

    def authorize_actions_on_one_ticket
      @ticket = Ticket.find(params[:id])
      authorize @ticket
    end

    def ticket_params
      params.require(:ticket).permit(:name, :description, :incident_id, :is_lead, :status_id, :priority_id, :tag_list, :parent_id, :assigned_to_id)
    end
end
