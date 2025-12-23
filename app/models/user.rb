class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, allow_nil: true, length: { minimum: 5 }, confirmation: true
  validates :full_name, presence: true, length: { minimum: 3 }
end
