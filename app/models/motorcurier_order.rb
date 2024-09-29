class MotorcurierOrder < ApplicationRecord
  belongs_to :order
  belongs_to :motor_curier
end
