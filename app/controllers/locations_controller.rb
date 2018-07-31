class LocationsController < ApplicationController
  def show
    render json: { location: location_object }, status: :ok
  end

  def index
    render json: { locations: Location.all }, status: :ok
  end

  def create
    business.locations.create!(location_params)
    response = {
      message: Message.location_created,
      location: business.locations.last
    }

    render json: response, status: :created
  end

  def update
    address = params[:address]
    response =
      if location_object.address.eql?(address) || address.blank?
        { message: Message.location_not_changed }
      else
        location_object.update(location_params)
        { message: Message.location_updated, location: location_object }
      end

    render json: response, status: 200
  end

  def destroy
    location_object.delete
    render json: { message: Message.location_deleted }, status: :ok
  end

  private

  def business
    Business.find(params[:business_id])
  end

  def location_params
    params.permit(:address)
  end

  def location_object
    business.locations.find(params[:id])
  end
end
