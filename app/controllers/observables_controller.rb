class ObservablesController < ApplicationController
  before_action :set_observable, only: [:show, :edit, :update, :destroy]
  before_action :set_ticket
  before_action :set_current_user

  # GET /observables
  # GET /observables.json
  def index
    @observables = Observable.all
  end

  # GET /observables/1
  # GET /observables/1.json
  def show
  end

  # GET /observables/new
  def new
    @observable = Observable.new
  end

  # GET /observables/1/edit
  def edit
  end

  # POST /observables
  # POST /observables.json
  def create
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
        format.html { render :edit }
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

    def set_ticket
        @ticket = Ticket.find(params[:ticket_id])
    end

    def set_current_user
        @current_user = current_user
    end

    def observable_params
      params.require(:observable).permit(:observable, :user_id, :ticket_id, :description)
    end
end
