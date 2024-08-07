class User < ApplicationRecord
  before_save :downcase_email
  attr_accessor :remember_token, :activation_token

  before_create :create_activation_digest

  PERMITTED_ATRIBUTES = %i(name email password password_confirmation).freeze
  validates :name, presence: true, length: {maximum: Settings.validate_len_name}
  validates :email, presence: true,
    length: {maximum: Settings.validate_len_email},
    format: {with: Settings.VALID_EMAIL_REGEX}, uniqueness: true
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.digits.digit_6}, allow_nil: true

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
    remember_digest
  end

  def session_token
    remember_digest || remember
  end

  def authenticated? attribute, token
    digest = public_send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_column(:remember_digest, nil)
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
