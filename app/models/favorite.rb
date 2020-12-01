class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :live_companion
end
