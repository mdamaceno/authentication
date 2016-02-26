module Authentication
  class ResetPasswordMailer < Authentication::ApplicationMailer
    def confirmation(receiver)
      @receiver = receiver
      mail(
        from: 'me@example.com',
        to: [@receiver.email],
        subject: 'Pedido de mudança de senha'
      )
    end
  end
end
