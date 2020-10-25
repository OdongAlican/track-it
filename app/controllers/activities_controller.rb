class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[show update destroy]

  def index
    @activities = Activity.all
    json_response(@activities)
  end

  def create
    @activity = Activity.create!(activity_params)
    json_response(@activity, :created)
  end

  def show
    json_response(@activity)
  end

  def update
    @activity.update(activity_params)
    json_response(@activity)
  end

  def destroy
    @activity.destroy
    head :no_content
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.permit(:title, :total, :avatar)
  end
end
