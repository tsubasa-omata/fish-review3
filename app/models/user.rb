class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  validates :name, presence: true,
                   length: { maximum: 10 }
  validates :account_name, presence: true, 
                           length: { maximum: 10 },
                           uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :prof, length: { maximum: 100 }                  
  validates :password, presence: true, 
                       length: { in: 6..10 },
                       allow_nil: true     #has_resure_passwordがあるから新規登録時空になることはない


  before_save :downcase_email
  before_create :create_activation_digest
  #mount_uploader :picture, ImageUploader
  has_secure_password

  def downcase_email
    self.email = email.downcase
  end

  def downcase_account_name
    self.account_name = account_name.downcase
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
 
  def remember
    self.remember_token = User.new_token                             #ここでuserの仮想属性remember_tokenに値を設定する
    update_attribute(:remember_digest, User.digest(remember_token))  #ここでダイジェスト化してremember_digestを更新する
  end

  def authenticated?(attribute ,token) #このtokenはよく分からない attributeが第一引数でtokenが第二引数呼び出す時は（第一引数、第二引数）という感じ 
    digest = send("#{attribute}_digest")    #sendメソッドのおかげでこれができる
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
end
