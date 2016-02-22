require 'test_helper'

module Authentication
  class UserTest < ActiveSupport::TestCase
    test 'should not save without email' do
      user = Authentication::User.new(attributes_for(:user, email: nil))
      refute user.save
    end
  end
end
