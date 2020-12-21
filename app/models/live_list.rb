class LiveList < ApplicationRecord
  belongs_to :user
  belongs_to :live_companion
  default_scope -> { order(schedule: :desc) }
  validates :user_id, presence: true
  validates :live_companion_id, presence: true
  validates :from_user_id, presence: true
end
