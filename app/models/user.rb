class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:steam]

  has_many :user_tokens
  has_many :giveaways

  def apply_omniauth(auth)
    self.steam_name = auth['info']['nickname']
    self.steam_image = auth['info']['image']

    user_tokens.build(:provider => auth['provider'],
                      :uid => auth['uid'])
  end

  def update_user_omniauth(auth)
    self.steam_name = auth['info']['nickname']
    self.steam_image = auth['info']['image']
  end

  def steam_token
    user_tokens.find_by_provider(:steam)
  end

  def admin?
    admin
  end

end
