class GiveawaysController < ApplicationController
  before_action :authenticate_user!

  def index
    
  end

  def show
    
  end

  def new
    
  end

  def create
    
  end

  def update
    
  end

  def destroy
    
  end

  private
  def giveaway_params
    params.require(:giveaway).permit(:game_name, :game_id)
  end
end
