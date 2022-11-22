class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, invite_for: 24.hours, validate_on_invite: true

  belongs_to :therapist
  has_many :client_records
  has_many :client_menus
  has_many :chats
  has_many :notifications
  has_one :room
  has_one_attached :client_image


  validates :last_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/,message: "は、漢字・ひらがなのどちらかで入力して下さい"}
  validates :first_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/, message: "は、漢字・ひらがなのどちらかで入力して下さい"}
  validates :last_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "は、全角カタカナのみで入力して下さい"}
  validates :first_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "は、全角カタカナのみで入力して下さい"}
  validates :purpose, presence: true

  # クライアント画像を取得しリサイズ
  def get_client_image(width, height)
    unless client_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      client_image.attach(io: File.open(file_path), filename: "no_image.jpg", content_type: "image/jpeg")
    end
    client_image.variant(resize_to_fill: [width, height]).processed
  end

  # クライアントの氏名を表示
  def client_name
    last_name + " " + first_name
  end

   # クライアントの氏名(カタカナ)を表示
  def client_name_kana
    last_name_kana + " " + first_name_kana
  end
end
