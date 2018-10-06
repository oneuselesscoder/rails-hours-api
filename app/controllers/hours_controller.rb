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
    return invalid_data(params) if params_present? && invalid_data? 
    @user.hours.create!(hour_params)
    json_response(@user, :created)
  end

  # PUT /users/:user_id/hours/:id
  def update
    return invalid_data(params) if params_present? && invalid_data?
    @hour.update(hour_params)
    head :no_content
  end

  # DELETE /users/:user_id/hours/:id
  def destroy
    @hour.destroy
    head :no_content
  end

  private

  def invalid_data?
    @user.unavailable?(params[:starts],params[:ends]) || invalid_range?
  end

  def invalid_range?
    DateTime.parse(params[:starts]) > DateTime.parse(params[:ends])
  end

  def params_present?
    params.has_key?(:starts) && params.has_key?(:ends)
  end

  def hour_params
    params.permit(:starts, :ends)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_user_hour
    @hour = @user.hours.find_by!(id: params[:id]) if @user
  end
end
