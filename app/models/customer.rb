class Customer < ApplicationRecord
  has_secure_password

  has_one :address, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  validates :document, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
