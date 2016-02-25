module Authentication
  class User < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged

    has_secure_password

    # Validations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, email_format: true
    validates :auth_token, length: { is: 88, allow_blank: true }
  end
end
