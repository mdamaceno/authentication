module Authentication
  class User < ActiveRecord::Base
    before_create :generate_authentication_token
    before_save   :downcase_email
    before_create :create_activation_digest

    # Validations
    validates :email, presence: true
    validates :password, length: { minimum: 6 }, allow_blank: true
    validates :password_confirmation, presence: true, if: '!password.nil?'
    validates :firstname, presence: true, length: { maximum: 50 }
    validates :lastname, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }

    # Remembers a user in the database for use in persistent sessions.
    def remember
      self.remember_token = Authentication::User.new_token
      update_attribute(:remember_digest, Authentication::User.digest(remember_token))
    end

    # Forgets a user.
    def forget
      update_attribute(:remember_digest, nil)
    end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end

    # Activates an account.
    def activate
      update_attribute(:activated,    true)
      update_attribute(:activated_at, Time.zone.now)
    end

    # Sets the password reset attributes.
    def create_reset_digest
      self.reset_token = User.new_token
      update_attribute(:reset_digest, User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end

    private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = Authentication::User.new_token
      self.activation_digest = Authentication::User.digest(activation_token)
    end

    def generate_authentication_token
      loop do
        self.authentication_token = SecureRandom.base64(64)
        break unless Authentication::User.find_by(authentication_token: authentication_token)
      end
    end
  end
end
