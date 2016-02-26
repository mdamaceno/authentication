require 'test_helper'

module Authentication
  class ResetPasswordMailerTest < ActionMailer::TestCase
    def setup
      @mailer = Authentication::ResetPasswordMailer
      @user = create(:user)
    end
    test 'reset' do
      email = ResetPasswordMailer.confirmation(@user)
                                 .deliver_now

      assert_not ActionMailer::Base.deliveries.empty?

      assert_equal ['me@example.com'], email.from
      assert_equal [@user.email], email.to
      assert_equal 'Pedido de mudança de senha', email.subject
    end
  end
end
