class Sensor < ApplicationRecord
  has_many :lectures
  belongs_to :user
  belongs_to :plant
end
