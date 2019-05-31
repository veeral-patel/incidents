class Incident < ApplicationRecord
    has_many :tickets

    def to_s
        self.name
    end
end
