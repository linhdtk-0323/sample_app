class User < ApplicationRecord
  before_save :downcase_email
  attr_accessor :remember_token

  PERMITTED_ATRIBUTES = %i(name email password password_confirmation).freeze
  validates :name, presence: true, length: {maximum: Settings.validate_len_name}
  validates :email, presence: true,
    length: {maximum: Settings.validate_len_email},
    format: {with: Settings.VALID_EMAIL_REGEX}, uniqueness: true
  has_secure_password

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost:
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_column(:remember_digest, nil)
  end

  private
  def downcase_email
    email.downcase!
  end
end
