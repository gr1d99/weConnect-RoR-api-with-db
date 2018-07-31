class Business < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :categories, presence: true
  validates :locations, presence: true

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :locations
end
