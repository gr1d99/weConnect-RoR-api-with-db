class LocationController < ApplicationController
  def create
    location = Location.create!(location_params)
    response = { message: Message.location_created, location: location }
    render json: response, status: :created
  end

  private

  def location_params
    params.permit(:address)
  end
end
