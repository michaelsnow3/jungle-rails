class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_many :reviews
  has_secure_password
end
