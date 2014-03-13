class User < ActiveRecord::Base
  # すべてのメアドを小文字で保存する処理
  # before_save { self.email = email.downcase } => 下の行と同じ挙動をする。なぜ？
  before_save { email.downcase! }
  before_create :create_remember_token
  # validates (カラム名, {設定のハッシュ値})
  #   => メソッドの()と最後の引数の{}は省略可能
  validates :name, presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
