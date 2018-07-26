class Location < ApplicationRecord
  validates :address, presence: true, uniqueness: true
  has_and_belongs_to_many :businesses
end
