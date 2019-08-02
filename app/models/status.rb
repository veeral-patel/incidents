class Status < ApplicationRecord
    validates :name, presence: true
end
