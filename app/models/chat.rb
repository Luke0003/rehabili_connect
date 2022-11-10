class Chat < ApplicationRecord
  belongs_to :room
  belongs_to :client, optional: true
  belongs_to :theraipst, optional: true

  validates :message, presence: true
end
