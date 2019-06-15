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

    # user.incidents returns the incidents an user created
    # user.joined_incidents returns the incidents an user is a member of
    has_and_belongs_to_many :joined_incidents, class_name: "Incident"

    def self.admins
        User.where(admin: true).where(deleted_at: nil)
    end

    def to_s
        self.username
    end

    def soft_delete  
        update_attribute(:deleted_at, Time.current)  
    end  
      
    # ensure user account is active  
    def active_for_authentication?  
        super && !deleted_at  
    end  
      
    # provide a custom message for a deleted account   
    def inactive_message   
        !deleted_at ? super : :deleted_account  
    end  

    # so you can login with your username ---------

    attr_writer :login

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
end

