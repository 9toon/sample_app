class User < ActiveRecord::Base
  # すべてのメアドを小文字で保存する処理
  before_save { self.email = email.downcase }
  # validates (カラム名, {設定のハッシュ値})
  #   => メソッドの()と最後の引数の{}は省略可能
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
end
