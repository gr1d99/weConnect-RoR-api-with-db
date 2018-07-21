class CategoryController < ApplicationController
  def create
    category = Category.create!(category_params)
    response = { category: category, message: Message.category_created }
    render json: response, status: :created
  end

  private

  def category_params
    params.permit(:name)
  end
end
