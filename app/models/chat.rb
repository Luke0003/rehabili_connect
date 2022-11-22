class Chat < ApplicationRecord
  belongs_to :room
  belongs_to :client, optional: true
  belongs_to :theraipst, optional: true
  has_one :notification

  validates :message, presence: true
end
