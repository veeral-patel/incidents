class Status < ApplicationRecord
    validates :code, presence: true # eg, 'in_progress'
    validates :name, presence: true # eg, 'In Progress'
end
