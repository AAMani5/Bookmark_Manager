require 'bcrypt'

class User
  include DataMapper::Resource

  property :id,         Serial
  property :email,      String
  property :password_salt,   Text

  # password will hold password & salt
  # password property is text not String coz pwd + salt will be > 50 chars
  # has n, :links

  def password=(password)
    self.password_salt = BCrypt::Password.create(password)
  end

end
