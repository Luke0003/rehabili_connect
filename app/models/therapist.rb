class Therapist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :clients
  has_one_attached :therapist_image

  validates :last_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/,message: "は、漢字・ひらがなのどちらかで入力して下さい"}
  validates :first_name, presence: :true, format: {with:/\A[一-龥ぁ-ん]/, message: "は、漢字・ひらがなのどちらかで入力して下さい"}
  validates :last_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "は、全角カタカナのみで入力して下さい"}
  validates :first_name_kana, presence: :true, format: {with:/\A[ァ-ヶー－]+\z/, message: "は、全角カタカナのみで入力して下さい"}

  # セラピスト画像を取得しリサイズ
  def get_therapist_image(width, height)
    unless therapist_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpeg")
      therapist_image.attach(io: File.open(file_path), filename: "no_image.jpeg", content_type: "image/jpeg")
    end
    therapist_image.variant(resize_to_fill: [width, height]).processed
  end

  # セラピストの氏名を表示
  def therapist_name
    last_name + " " + first_name
  end

   # セラピストの氏名(カタカナ)を表示
  def therapist_name_kana
    last_name_kana + " " + first_name_kana
  end
end
