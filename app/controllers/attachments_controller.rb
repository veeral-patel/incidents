class AttachmentsController < ApplicationController
  before_action :set_attachment, only: [:show, :edit, :update, :destroy]
  before_action :set_ticket

  # GET /tickets/1/attachments
  # GET /tickets/1/attachments.json
  def index
  end

  # GET /tickets/1/attachments/1
  # GET /tickets/1/attachments/1.json
  def show
  end

  # GET /tickets/1/attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /tickets/1/attachments/1/edit
  def edit
  end

  # POST /tickets/1/attachments
  # POST /tickets/1/attachments.json
  def create
    @attachment = Attachment.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to ticket_attachment_path(@ticket, @attachment), notice: 'Attachment was successfully created.' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1/attachments/1
  # PATCH/PUT /tickets/1/attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to ticket_attachment_path(@ticket, @attachment), notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1/attachments/1
  # DELETE /tickets/1/attachments/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to ticket_attachments_path(@ticket), notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:description, :ticket_id, :file)
    end
end
