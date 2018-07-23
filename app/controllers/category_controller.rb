class CategoryController < ApplicationController
  def create
    category = Category.create!(category_params)
    response = { category: category, message: Message.category_created }
    render json: response, status: :created
  end

  def update
    id = update_params[:id]
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

  def category_params
    params.permit(:name)
  end

  def update_params
    params.permit(:name, :id)
  end

  def find_category
    Category.find(params[:id])
  end
end
