class Business < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :locations
end
