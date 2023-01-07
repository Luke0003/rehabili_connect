class ForgotToRecordMailer < ApplicationMailer

  default from: 'from@example.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.forgot_to_record_mailer.forgot_to_record_notification.subject
  #
  def forgot_to_record_notification
    @url = ENV['API_ENDPOINT']
    forgot_to_record_client =
      Client.all.select do |client|
        client if client.client_records.where(record_date: Time.zone.today).empty?
      end
    forgot_to_record_client_mails = forgot_to_record_client.pluck(:email)
    mail(bcc: forgot_to_record_client_mails, subject: "本日の記録が未登録です")
  end
end
