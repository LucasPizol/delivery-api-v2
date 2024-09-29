class Company < ApplicationRecord
  has_many :users
  has_one :address
  has_many :motor_couriers

  validates :name, presence: true
  validates :document, presence: true, uniqueness: true
  validates :phone, presence: true
end
