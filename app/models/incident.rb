class Incident < ApplicationRecord
    validates :name, presence: true
    has_many :tickets

    def to_s
        self.name
    end
end
