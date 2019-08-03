class AttachmentsController < ApplicationController
  # authorize each action
  before_action :authorize_actions_on_one_attachment, except: [:index, :create, :new]

  before_action :set_attachment, only: [:show, :update, :destroy]
  before_action :set_ticket

  # verify each action is authorized
  after_action :verify_authorized, except: [:index, :new, :create]

  # GET /tickets/1/attachments
  # GET /tickets/1/attachments.json
  def index
    raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?
  end

  # GET /tickets/1/attachments/1
  # GET /tickets/1/attachments/1.json
  def show
  end

  # GET /tickets/1/attachments/new
  def new
    raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?
    @attachment = Attachment.new
  end

  # POST /tickets/1/attachments
  # POST /tickets/1/attachments.json
  def create
    raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?

    @attachment = Attachment.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to ticket_attachment_path(@ticket, @attachment), notice: 'Attachment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tickets/1/attachments/1
  # PATCH/PUT /tickets/1/attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to ticket_attachment_path(@ticket, @attachment), notice: 'Attachment was successfully updated.' }
      else
        format.html { render :show }
      end
    end
  end

  # DELETE /tickets/1/attachments/1
  # DELETE /tickets/1/attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to ticket_attachments_path(@ticket), notice: 'Attachment was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
      @incident = @ticket.incident
    end

    def authorize_actions_on_one_attachment
      @attachment = Attachment.find(params[:id])
      authorize @attachment
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:description, :ticket_id, :file, :tag_list)
    end
end
