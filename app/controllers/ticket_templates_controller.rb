class TicketTemplatesController < ApplicationController
  before_action :set_ticket_template, only: [:edit, :update, :destroy, :tree]

  # GET /ticket_templates
  # GET /ticket_templates.json
  def index
    @ticket_templates = TicketTemplate.root_templates
  end

  # GET /ticket_templates/1/edit
  def edit
  end

  # PATCH/PUT /ticket_templates/1
  def update
    respond_to do |format|
      if @ticket_template.update(ticket_template_params)
        format.html { redirect_to edit_ticket_template_path(@ticket_template), notice: 'Ticket template was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /ticket_templates/1
  def destroy
    @ticket_template.destroy
    respond_to do |format|
      format.html { redirect_to ticket_templates_url, notice: 'Ticket template was successfully destroyed.' }
    end
  end

  # GET /ticket_templates/1/tree
  def tree
    gon.push({ template_tree_as_json: @ticket_template.to_json })

    respond_to do |format|
      format.html { render :tree }
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
