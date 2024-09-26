class Address < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :customer, optional: true
end
