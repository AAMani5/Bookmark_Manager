require 'bcrypt'

class User
  include DataMapper::Resource

  property :id,         Serial
  property :email,      String, :required => true, :format => :email_address, :unique => true,
  :messages => {
     :presence  => "We need your email address.",
     :is_unique => "We already have that email.",
     :format    => "Doesn't look like an email address to me ..."
   }
  property :password_salt,   Text

  attr_accessor :password_confirmation # write access for User.create method in bookmark_manager.rb, read access for validates_confirmation_of method
  attr_reader :password # read access to validates_confirmation_of method

  # password will hold password & salt
  # password property is text not String coz pwd + salt will be > 50 chars
  # has n, :links

  def password=(password)
    @password = password
    self.password_salt = BCrypt::Password.create(password)
  end

  # validates_format_of :email, as: :email_address # :format => :email_address with property creates this line implicitly
  validates_confirmation_of :password, :message => "Password and confirmation password do not match" # model will save and be valid only if password == password_confirmation
  # validates_presence_of :email # can also say :required => true when property decalred
end
