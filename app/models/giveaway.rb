class Giveaway < ActiveRecord::Base
  validates :game_name, presence: true
  validates :user_id, presence: true

  has_many :participations
  has_many :user, :through => :participations

  def self.find_owner(id)
    self.where(id: id).pluck(:user_id).first
  end
end
