class User
  include Mongoid::Document


  before_save :encrypt_password

  attr_accessor :password
  attr_accessible :password

  field :username
  field :password_hash
  field :password_salt

  field :email



  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :password, presence: true, on: :create

  has_many :vitae

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(username, password)
    user = where(username: username).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end