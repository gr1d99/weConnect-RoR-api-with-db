class LocationController < ApplicationController
  def create
    location = Location.create!(location_params)
    response = { message: Message.location_created, location: location }
    render json: response, status: :created
  end

  def update
    address = params[:address]
    response = if location_object.address.eql?(address) || address.blank?
                 { message: Message.location_not_changed }
               else
                 location_object.update(location_params)
                 { message: Message.location_updated, location: location_object }
               end

    render json: response, status: 200
  end


  private

  def location_params
    params.permit(:address)
  end

  def location_object
    Location.find(params[:id])
  end
end
