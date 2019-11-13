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
                       length: { in: 6..10 }

  before_save :downcase_email
  #mount_uploader :picture, ImageUploader
  has_secure_password

  def downcase_email
    self.email = email.downcase
  end

  def downcase_account_name
    self.account_name = account_name.downcase
  end




end
