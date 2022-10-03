class User < Ohm::Model
  include Ohm::Callbacks
  include Ohm::Validations

  require 'bcrypt'

  attribute :username
  attribute :password
  attribute :password_confirmation
  attribute :password_digest
  
  unique :username
  index :username

  counter :login_counts
  counter :failed_login_attempts


  def before_save
    encrypt_password!
  end

  def success_login
    self.incr :login_counts
  end

  def failed_login
    self.incr :failed_login_attempts
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password && self
  end

  protected

  def validate
    # Additional validations for User attributes
    password_complexity
  end

  def password_complexity
    if password.present?
      # To update for more complexity in the future
      if !password.match(/^(?=.*[a-z])(?=.*[A-Z])/) 
        raise StandardError.new "Password complexity requirement not met"
      end
    end
  end

  def encrypt_password!
    unless password == password_confirmation
      raise StandardError.new "Password Confirmation doesn't match"
    end

    cost = BCrypt::Engine.cost
    self.password_digest = BCrypt::Password.create(password, cost: cost)
    self.password = nil
    self.password_confirmation = nil
  end
end
