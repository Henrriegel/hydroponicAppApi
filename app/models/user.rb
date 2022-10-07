class User < ApplicationRecord
  has_secure_password
  has_many :sensors

  validates :email, presence: true
  validates :password, presence: true, length: {minimum:6}

end
