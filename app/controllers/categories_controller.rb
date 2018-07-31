class CategoriesController < ApplicationController
  def index
    categories = Category.all

    render json: { categories: categories }, status: :ok
  end

  def show
    category = find_category
    render json: { category: category }, status: :ok
  end

  def create
    category = Category.create!(category_params)
    business.categories.append(category)
    response = { category: category, message: Message.category_created }

    render json: response, status: :created
  end

  def update
    category = find_category
    category.update(update_params)
    response = { category: category, message: Message.category_updated }

    render json: response, status: :ok
  end

  def destroy
    category = find_category
    category.destroy

    render json: { message: Message.category_deleted }, status: :ok
  end

  private

  def business
    Business.find(params[:business_id])
  end

  def category_params
    params.permit(:name)
  end

  def update_params
    params.permit(:name, :id)
  end

  def find_category
    business.categories.find(params[:id])
  end
end
