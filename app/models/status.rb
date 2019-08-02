class Status < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end
