class TicketTemplatesController < ApplicationController
  before_action :set_ticket_template, only: [:show, :edit, :update, :destroy]

  # GET /ticket_templates
  # GET /ticket_templates.json
  def index
    @ticket_templates = TicketTemplate.all
  end

  # GET /ticket_templates/1
  # GET /ticket_templates/1.json
  def show
  end

  # GET /ticket_templates/new
  def new
    @ticket_template = TicketTemplate.new
  end

  # GET /ticket_templates/1/edit
  def edit
  end

  # POST /ticket_templates
  # POST /ticket_templates.json
  def create
    @ticket_template = TicketTemplate.new(ticket_template_params)

    respond_to do |format|
      if @ticket_template.save
        format.html { redirect_to @ticket_template, notice: 'Ticket template was successfully created.' }
        format.json { render :show, status: :created, location: @ticket_template }
      else
        format.html { render :new }
        format.json { render json: @ticket_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ticket_templates/1
  # PATCH/PUT /ticket_templates/1.json
  def update
    respond_to do |format|
      if @ticket_template.update(ticket_template_params)
        format.html { redirect_to @ticket_template, notice: 'Ticket template was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket_template }
      else
        format.html { render :edit }
        format.json { render json: @ticket_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_templates/1
  # DELETE /ticket_templates/1.json
  def destroy
    @ticket_template.destroy
    respond_to do |format|
      format.html { redirect_to ticket_templates_url, notice: 'Ticket template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket_template
      @ticket_template = TicketTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_template_params
      params.require(:ticket_template).permit(:name, :description)
    end
end
