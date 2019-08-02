class Priority < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    def to_s
        self.name
    end
end
