class LiveCompanion < ApplicationRecord
  has_many :live_companion, dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :artist_name, presence: true, length: { maximum: 30 }
  validates :live_name, presence: true, length: { maximum: 30 }
  validates :live_memo, length: { maximum: 140 }
end
