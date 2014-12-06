class UserToken < ActiveRecord::Base
  belongs_to :user

  def update_omniauth(auth) 
    self.provider     = auth['provider']
    self.uid          = auth['uid']
  end
end
