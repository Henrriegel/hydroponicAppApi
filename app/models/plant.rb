class Plant < ApplicationRecord
    has_many :sensors
    has_many :parameters
end
