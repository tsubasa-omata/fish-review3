class User < ApplicationRecord
  #attr_accessor :remember_token, :activation_token, :reset_token
  validates :name, presence: true, length: { maximum: 50 }
  #validates :account_name, presence: true, length: { maximun: 10 },
  #                        uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                   format: { with: VALID_EMAIL_REGEX },
                   uniqueness: { case_sensitive: false }
  
  #mount_uploader :picture, ImageUploader
  #has_secure_password
end
