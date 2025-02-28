class NotificationFromAdminMailer < ApplicationMailer
  def notify(user, msg)
    @msg = msg
    mail(
      to: user.email,
      subject: '運営からのお知らせ'
    )
  end
end
