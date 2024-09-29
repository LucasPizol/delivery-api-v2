class MotorCurier < ApplicationRecord
  has_one :company
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
