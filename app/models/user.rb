class User < ApplicationRecord
  has_many   :addresses , dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :items
  has_one :pay



  validates :nickname, :last_name, :first_name, presence: true

  validates :birthdate_year, inclusion: { in: (1..51), message: 'を選択してくださいしてください。' }
  validates :birthdate_month, inclusion: { in: [1,2,3,4,5,6,7,8,9,10,11,12], message: 'を選択してくださいしてください。' }
  validates :birthdate_day, inclusion: { in: (1..31), message: 'を選択してくださいしてください。'}

  # # 空の、同じメールアドレスを登録しない、＠を含んだメールアドレス
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: VALID_EMAIL_REGEX, message: 'の後に@,ドメインを含ませてください' }
    
  devise :validatable, password_length: 7..15
  # ７文字以上、英数字のみ可
  validates :password,
    format: { with: /\A[a-z0-9]+\z/i, message: 'は英数字で入力してください。' }

  # 全角 漢字ひらがなのみ可
  validates :last_name,
  format: { with: /\A[一-龥ぁ-ん]/, message: 'は漢字、ひらがなで入力してください。'}
  validates :first_name,
  format: { with: /\A[一-龥ぁ-ん]/, message: 'は漢字、ひらがなで入力してください。'}

  # カナのみ可
    validates :last_name_kana, :first_name_kana, presence: true,
    format: { with: /\A([ァ-ン]|ー)+\z/, message: 'はカナで入力してください。'}

      

end
