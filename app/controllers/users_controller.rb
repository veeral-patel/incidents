class UsersController < ApplicationController
  before_action :set_user, only: [:enable, :destroy]
  before_action :authorize_admin

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1/enable
  def enable
    @user.soft_restore
    respond_to do |format|
      format.html { redirect_to users_url, notice: "#{@user} was successfully enabled." }
      format.json { head :no_content }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.soft_delete

    respond_to do |format|
      format.html { redirect_to users_url, notice: "#{@user} was successfully disabled." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end

    def authorize_admin
      return unless !current_user.admin?
      redirect_to root_path, alert: 'Admins only!'
    end
end
