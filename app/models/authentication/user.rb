module Authentication
  class User < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged

    # Validations
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, email_format: true
  end
end
