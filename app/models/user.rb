class User < ApplicationRecord
  has_secure_password
  has_many :sensors
  has_many :parameters

  validates :email, presence: true
  validates :password, length: {minimum:6}

end
