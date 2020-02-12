class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :reviews, dependent: :destroy
  has_one_attached :avatar
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :comments
  has_many :likes, dependent: :destroy
  
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
  has_secure_password

  def downcase_email
    self.email = email.downcase
  end

  def downcase_account_name
    self.account_name = account_name.downcase
  end

  def follow(other_user)
    active_relationships.create(followed: other_user)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed: other_user).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Review.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
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
    self.remember_token = User.new_token                             #userの仮想属性remember_tokenに値を設定する
    update_attribute(:remember_digest, User.digest(remember_token))  #ダイジェスト化してremember_digestを更新する
  end

  def authenticated?(attribute ,token) 
    digest = send("#{attribute}_digest")    
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
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

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
end
