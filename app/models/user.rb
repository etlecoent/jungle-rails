class User < ActiveRecord::Base

  has_secure_password

  validates :password, presence: true, length: { minimum: 10 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: true}
  validates :first_name, presence: true
  validates :last_name, presence: true
end