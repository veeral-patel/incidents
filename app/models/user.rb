class User < ApplicationRecord
   devise :two_factor_authenticatable, :otp_secret_encryption_key => ENV["2FA_KEY"]

    acts_as_token_authenticatable

    devise :invitable, :recoverable, :rememberable, :validatable

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

    # user.tickets returns the tickets an user created
    # user.joined_tickets returns the tickets in incidents an user is a member of
    def joined_tickets
        Ticket.where(incident: self.joined_incidents)
    end

    def status
        if not self.active_for_authentication?
            return :disabled
        elsif self.invitation_sent_at?
            if self.invitation_accepted?
                return :invitation_accepted
            else 
                return :invitation_pending
            end
        else
            return :created_manually
        end
    end

    def to_s
        self.username
    end

    def soft_delete  
        update_attribute(:deleted_at, Time.current)  
    end  
      
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

    def activate_otp
        self.otp_required_for_login = true
        self.otp_secret = unconfirmed_otp_secret
        self.unconfirmed_otp_secret = nil
        save!
      end
    
    def deactivate_otp
        self.otp_required_for_login = false
        self.otp_secret = nil
        save!
    end
end

