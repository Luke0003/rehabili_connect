require "test_helper"

class ForgotToRecordMailerTest < ActionMailer::TestCase
  test "forgot_to_record_notification" do
    mail = ForgotToRecordMailer.forgot_to_record_notification
    assert_equal "Forgot to record notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
