class Tenant < ApplicationRecord
    validates :name, presence: true, uniqueness: true, with: /^[A-Za-z0-9]+$/
end
