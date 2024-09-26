class Order < ApplicationRecord
  belongs_to :address
  belongs_to :company
  belongs_to :customer
end
