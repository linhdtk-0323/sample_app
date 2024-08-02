class User < ApplicationRecord
  before_save :downcase_email
  after_update :run_callback_after_update

  validates :name, presence: true, length: {maximum: Settings.validate_len_name}
  validates :email, presence: true,
    length: {maximum: Settings.validate_len_email},
    format: {with: Settings.VALID_EMAIL_REGEX}, uniqueness: true
  has_secure_password

  private
  
  def downcase_email
    email.downcase!
  end
end
