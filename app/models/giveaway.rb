class Giveaway < ActiveRecord::Base
  validates :game_name, presence: true
  validates :user_id, presence: true

  has_many :participations
  has_and_belongs_to_many :user, :through => :participations
  belongs_to :user, class_name: User

  def self.find_owner(id)
    self.where(id: id).pluck(:user_id).first
  end
end
