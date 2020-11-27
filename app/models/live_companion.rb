class LiveCompanion < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :artist_name, presence: true, length: { maximum: 30 }
  validates :live_name, presence: true, length: { maximum: 30 }
  validates :live_memo, length: { maximum: 140 }
end
