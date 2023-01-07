# Preview all emails at http://localhost:3000/rails/mailers/forgot_to_record_mailer
class ForgotToRecordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/forgot_to_record_mailer/forgot_to_record_notification
  def forgot_to_record_notification
    ForgotToRecordMailer.forgot_to_record_notification
  end

end
