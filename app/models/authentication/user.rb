module Authentication
  class User < ActiveRecord::Base
    # Validations
    validates :email, presence: true
  end
end
