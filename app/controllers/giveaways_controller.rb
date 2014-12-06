class GiveawaysController < ApplicationController
  before_action :authenticate_user!

  def index
    @giveaways = Giveaway.all
  end

  def show
    @giveaway = Giveaway.find(params[:id])
  end

  def new
    @giveaway = Giveaway.new
  end

  def create
    @giveaway = Giveaway.new(giveaway_params)
    @giveaway.user_id = current_user.id

    if @giveaway.save
      redirect_to root_url
    else
      render 'new'
    end

  end

  def update
    
  end

  def destroy
    
  end

  private
  def giveaway_params
    params.require(:giveaway).permit(:game_name)
  end
end
