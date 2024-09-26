class User < ApplicationRecord
  has_secure_password

  belongs_to :company

  validates :name, presence: true
  validates :document, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :password_digest, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
