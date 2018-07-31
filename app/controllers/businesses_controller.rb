class BusinessesController < ApplicationController
  def index
    render json: { businesses: Business.all }, status: :ok
  end

  def show
    render json: business_response(business), status: :ok
  end

  def create
    business = Business.create!(
      name: business_params[:name],
      categories: [category],
      locations: [location]
    )
    response = { business: business, message: Message.business_created }

    render json: response, status: :created
  end

  def update
    business.update(name: business_params[:name])
    business.update_location(business_params[:location_id])
    business.update_category(business_params[:category_id])
    response =
      {
        business: business_response(business),
        message: Message.business_updated
      }

    render json: response, status: :ok
  end

  def destroy
    business.destroy
    render json: { message: Message.business_deleted }, status: :ok
  end

  private

  def business_params
    params.permit(
      :name,
      :location_id,
      :category_id
    )
  end

  def business
    Business.find(params[:id])
  end

  def location
    Location.find(business_params[:location_id])
  end

  def category
    Category.find(business_params[:category_id])
  end

  def business_response(business)
    {
      business: business,
      locations: business.locations,
      categories: business.categories,
      message: Message.business_created
    }
  end
end
