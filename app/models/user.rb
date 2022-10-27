class User < ApplicationRecord
  has_secure_password
  has_many :sensors
  has_many :parameters

  validates :email, presence: true
  #Uncomment next if password needs validation and minimum length
  #validates :password, presence: true, length: {minimum:6}

end
