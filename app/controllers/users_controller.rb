class UsersController < ApplicationController
  def show
    @user               = User.find(params[:id])
    @owns_giveaways     = @user.giveaways
    @joined_giveaways   = @user.participations
  end

  def update
  end
end
