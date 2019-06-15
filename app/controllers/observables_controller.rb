class ObservablesController < ApplicationController
  # authorize each action
  before_action :authorize_actions_on_one_observable, except: [:index, :create, :new]

  before_action :set_observable, only: [:show, :update, :destroy]
  before_action :set_ticket_and_incident
  before_action :set_current_user

  # verify each action is authorized
  after_action :verify_authorized

  # GET /observables
  # GET /observables.json
  def index
      # if you can't see a ticket, you can't see its observables
      raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?
  end

  # GET /observables/1
  # GET /observables/1.json
  def show
  end

  # GET /observables/new
  def new
    # if you can't see a ticket, you can't see its observables
    raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?

    @observable = Observable.new
  end

  # POST /observables
  # POST /observables.json
  def create
    # if you can't see a ticket, you can't create an observable in it
    raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?

    @observable = current_user.observables.new(observable_params)

    respond_to do |format|
      if @observable.save
        format.html { redirect_to ticket_observable_path(@ticket, @observable), notice: 'Observable was successfully created.' }
        format.json { render :show, status: :created, location: @observable }
      else
        format.html { render :new }
        format.json { render json: @observable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observables/1
  # PATCH/PUT /observables/1.json
  def update
    respond_to do |format|
      if @observable.update(observable_params)
        format.html { redirect_to ticket_observable_path(@ticket, @observable), notice: 'Observable was successfully updated.' }
        format.json { render :show, status: :ok, location: @observable }
      else
        format.html { render :show }
        format.json { render json: @observable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observables/1
  # DELETE /observables/1.json
  def destroy
    @observable.destroy
    respond_to do |format|
      format.html { redirect_to ticket_observables_path(@ticket), notice: 'Observable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_observable
      @observable = Observable.find(params[:id])
    end

    def set_ticket_and_incident
        @ticket = Ticket.find(params[:ticket_id])
        @incident = @ticket.incident
    end

    def set_current_user
        @current_user = current_user
    end

    def authorize_actions_on_one_observable
      @observable = Observable.find(params[:id])
      authorize @observable
    end

    def observable_params
      params.require(:observable).permit(:observable, :user_id, :ticket_id, :description, :tag_list)
    end
end
