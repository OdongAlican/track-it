class MeasurementsController < ApplicationController
  before_action :set_activity
  before_action :set_activity_measurement, only: %i[show update destroy]

  def index
    json_response(@activity.measurements)
  end

  def show
    json_response(@measurement)
  end

  def create
    @activity.measurements.create!(measurement_params)
    json_response(@activity, :created)
  end

  def update
    @measurement.update(measurement_params)
    head :no_content
  end

  def destroy
    @measurement.destroy
    head :no_content
  end

  private

  def measurement_params
    params.permit(:date, :duration)
  end

  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_activity_measurement
    @measurement = @activity.measurements.find_by!(id: params[:id]) if @activity
  end
end
