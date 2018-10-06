class HoursController < ApplicationController
  before_action :set_user
  before_action :set_user_hour, only: [:show, :update, :destroy]

  # GET /users/:user_id/hours
  def index
    json_response(@user.hours)
  end

  # GET /users/:user_id/hours/:id
  def show
    json_response(@hour)
  end

  # POST /users/:user_id/hours
  def create
    @user.hours.create!(hour_params)
    json_response(@user, :created)
  end

  # PUT /users/:user_id/hours/:id
  def update
    @hour.update(hour_params)
    head :no_content
  end

  # DELETE /users/:user_id/hours/:id
  def destroy
    @hour.destroy
    head :no_content
  end

  private

  def hour_params
    params.permit(:starts, :ends, :valid_date)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_hour
    @hour = @user.hours.find_by!(id: params[:id]) if @user
  end
end
