class Location < ApplicationRecord
  validates :address, presence: true
  has_and_belongs_to_many :businesses
end
