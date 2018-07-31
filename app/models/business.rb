class Business < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :locations

  def update_location(location_id)
    return unless location_id
    location = Location.find(location_id)

    locations.append(location) unless locations.include? location
  end

  def update_category(category_id)
    return unless category_id
    category = Category.find(category_id)

    categories.append(category) unless categories.include? category
  end

  def detail
    business = as_json
    business[:categories] = categories
    business[:locations] = locations
    { business: business }
  end
end
