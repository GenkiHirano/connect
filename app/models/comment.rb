class Comment < ApplicationRecord
  belongs_to :live_companion
  validates :user_id, presence: true
  validates :live_companion_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end
