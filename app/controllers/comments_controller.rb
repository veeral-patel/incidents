class CommentsController < ApplicationController
    # authorize each action
  before_action :authorize_actions_on_one_comment, except: [:index, :create, :new]
  
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_ticket
  before_action :set_current_user

  # verify each action is authorized
  after_action :verify_authorized, except: [:index, :new, :create]

  def index
      # if you can't see a ticket, you can't see its comments
      raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?
  end

  def show
  end

  def new
    # if you can't see a ticket, you can't create a comment in it
    raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?

    @comment = Comment.new
  end

  def create
    # if you can't see a ticket, you can't create a comment in it
    raise Pundit::NotAuthorizedError unless TicketPolicy.new(current_user, @ticket).show?

    @comment = current_user.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to ticket_comment_path(@ticket, @comment), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to ticket_comment_path(@ticket, @comment), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :show }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to ticket_comments_path(@ticket), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end
    
    def set_ticket
        @ticket = Ticket.find(params[:ticket_id])
        @incident = @ticket.incident
    end

    def set_current_user
        @current_user = current_user
    end

    def authorize_actions_on_one_comment
      @comment = Comment.find(params[:id])
      authorize @comment
    end

    def comment_params
      params.require(:comment).permit(:user_id, :ticket_id, :comment)
    end
end
