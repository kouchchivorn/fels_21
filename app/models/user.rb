class User < ActiveRecord::Base
    attr_accessor :require_password, :remember_token
    before_save {self.email = email.downcase}
    validates :name, presence: true, length: { maximum: 40}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 100},
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false}
    has_secure_password
    validates :password, length: {minimum: 6}, if: :require_password

    has_many :lessons, dependent: :destroy

    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    def User.digest(token)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                                                         BCrypt::Engine.cost
        BCrypt::Password.create(token, cost: cost)
    end

    def forget
        self.require_password = false
        update_attributes! remember_digest: nil
        self.require_password = true
    end

    def remember
        self.remember_token = User.new_remember_token
        self.require_password = false
        update_attributes! remember_digest: User.digest(remember_token)
        self.require_password = true
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    private

        def create_remember_token
            self.remember_token = User.digest(User.new_remember_token)
        end
end
