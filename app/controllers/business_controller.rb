class BusinessController < ApplicationController
  def create
    business = Business.create!(
      name: business_params[:name],
      categories: [category],
      locations: [location]
    )
    response = { business: business, message: Message.business_created }
    render json: response, status: :created
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
end
