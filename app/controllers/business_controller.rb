class BusinessController < ApplicationController
  def index
    render json: { businesses: Business.all }, status: :ok
  end

  def create
    business = Business.create!(
      name: business_params[:name], categories: [category], locations: [location]
    )
    render json: { business: business }, status: :created
  end

  private

  def business_params
    params.permit(
      :name,
      :location_id,
      :category_id
    )
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
