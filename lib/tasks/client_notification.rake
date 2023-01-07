namespace :client_notification do
 desc '記録をし忘れた利用者にメールを送る'
 task mail_to_client: :environment do
   ForgotToRecordMailer.forgot_to_record_notification.deliver_now
 end
end