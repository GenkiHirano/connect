class LiveCompanion < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :artist_name, presence: true, length: { maximum: 30 }
  validates :live_name, presence: true, length: { maximum: 30 }
  validates :live_memo, length: { maximum: 140 }
end
