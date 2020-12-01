class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :live_companion
  validates :user_id, presence: true
  validates :dish_id, presence: true
end
