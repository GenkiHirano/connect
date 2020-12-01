class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :live_companion
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :live_companion_id, presence: true
end
