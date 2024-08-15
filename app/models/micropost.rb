class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: Settings.resize_to_limit
  end

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.maximum_140}
  validates :image, content_type: {in: Settings.accept_file,
                                   message: I18n.t("message_upload")},
                    size: {less_than: Settings.file_5.megabytes,
                           message: I18n.t("file_size")}

  scope :recent_posts, ->{order created_at: :desc}
  scope :relate_post, ->(user_ids){where user_id: user_ids.present?}
end
