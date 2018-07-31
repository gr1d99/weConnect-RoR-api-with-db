class BusinessesController < ApplicationController
  def index
    render json: { businesses: Business.all }, status: :ok
  end

  def show
    render json: business.detail, status: :ok
  end

  def create
    business = Business.create!(
      name: business_params[:name]
    )
    response = { business: business, message: Message.business_created }

    render json: response, status: :created
  end

  def update
    business.update(name: business_params[:name])
    response = { business: business, message: Message.business_updated }

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
end
