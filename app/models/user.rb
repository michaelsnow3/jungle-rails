class User < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  has_many :reviews
  has_secure_password

  # user authentication class method
  def self.authenticate_with_credentials(email, password)
    striped_email = email.strip
    @user = User.where("LOWER(email) = ?", striped_email.downcase).first 
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
