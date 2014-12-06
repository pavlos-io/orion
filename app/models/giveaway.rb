class Giveaway < ActiveRecord::Base
  validates :game_name, presence: true
  validates :user_id, presence: true

  belongs_to :user

  def self.find_owner(id)
    self.where(id: id).pluck(:user_id).first
  end
end
