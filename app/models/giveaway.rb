class Giveaway < ActiveRecord::Base
  validates :game_name, presence: true
  validates :user_id, presence: true

  belongs_to :user
end
