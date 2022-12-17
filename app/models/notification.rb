class Notification < ApplicationRecord
  belongs_to :chat
  belongs_to :client
  belongs_to :therapist

  # クライアントの通知の数を取得
  def self.client_notifications_count(client)
    count = 0
    notifications = Notification.where(client_id: client.id)
    notifications.each do |notification|
      if notification.checked_client == false
        count += 1
      end
    end
    return count
  end

  # セラピストの通知の数を取得
  def self.therapist_notifications_count(client, therapist)
    count = 0
    notifications = Notification.where(client_id: client.id, therapist_id: therapist.id)
    notifications.each do |notification|
      if notification.checked_therapist == false
        count += 1
      end
    end
    return count
  end
  
  # クライアントへの通知を未読から既読へ変更
  def self.change_from_unread_to_read(client)
    notifications = client.notifications
    notifications.each do |notification|
      if notification.checked_client == false
        notification.update(checked_client: true)
      end
    end
  end

end
