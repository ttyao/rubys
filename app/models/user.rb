class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with:VALID_EMAIL_REGEX}, uniqueness: true
  validates :name, presence: true, length: { maximum: 50}
  has_secure_password
  validates :password, length: { minimum: 3 }
end
