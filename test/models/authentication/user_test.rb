require 'test_helper'

module Authentication
  class UserTest < ActiveSupport::TestCase
    test 'should not save without name' do
      user = Authentication::User.new(attributes_for(:user, name: nil))
      refute user.save
    end

    test 'should not save without email' do
      user = Authentication::User.new(attributes_for(:user, email: nil))
      refute user.save
    end

    test 'should not save if email already exists' do
      user1 = create(:user, email: 'email@example.com')
      user2 = build(:user, email: 'email@example.com')
      refute user2.save
    end

    test 'should not save if email has an invalid format' do
      ['email@', 'www.site.com', 'email@example', '@example.com'].each do |email|
        user = build(:user, email: email)
        refute user.save
      end
    end
  end
end
