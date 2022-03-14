class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true, length: { minimum: 3 }
  validates :name, presence: true

  def self.authenticate_with_credentials(email, password) 
    email = email.downcase.strip
    user = User.find_by_email(email)
    user.authenticate(password)
  end
end
