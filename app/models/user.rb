class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true, length: { minimum: 3 }
  validates :name, presence: true

  before_save do 
    self.email.downcase! if self.email
    self.email.strip! if self.email
  end

  def self.authenticate_with_credentials(email, password) 
    uemail = email.downcase.strip
    user = User.find_by_email(uemail)
    user.authenticate(password)
  end
end
