class Address < ApplicationRecord
  belongs_to :company, optional: true
end
