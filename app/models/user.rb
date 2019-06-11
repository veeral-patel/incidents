class User < ApplicationRecord
    acts_as_token_authenticatable

    devise :invitable, :database_authenticatable, :recoverable, :rememberable, :validatable

    validate :validate_username
    validates :username, presence: true
    validates_uniqueness_of :username

    has_many :incidents
    has_many :tickets
    has_many :comments
    has_many :observables

    attr_writer :login

    def assigned_tickets
        Ticket.where(assigned_to: self)
    end

    def login
        @login || self.username || self.email
    end

    def self.find_for_database_authentication(warden_conditions)
        conditions = warden_conditions.dup
        if login = conditions.delete(:login)
            where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
        elsif conditions.has_key?(:username) || conditions.has_key?(:email)
            where(conditions.to_hash).first
        end
    end

    def validate_username
        # edge case in devise
        if User.where(email: username).exists?
            errors.add(:username, :invalid)
        end
    end

    def to_s
        self.username
    end
end

