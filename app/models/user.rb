require "bcrypt"
class User < ActiveRecord::Base
	include BCrypt

	has_many :resources	

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :password_digest, presence: true
	validates :password_confirmation, presence: true
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

	has_secure_password

	validates_length_of :password_digest, minimum: 6
	validates_length_of :password_confirmation, minimum: 6
	validates_uniqueness_of :email
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
	
	def password
  		@password
    end

	def password=(new_password)
	  	 @password = new_password
	    self.password_digest = BCrypt::Password.create(new_password)
	end

	def authenticate(test_password)
	    if BCrypt::Password.new(self.password_digest) == test_password
	      self
	    else
	      false
	    end
	end

end
