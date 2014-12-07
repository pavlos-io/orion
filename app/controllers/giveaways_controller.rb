class GiveawaysController < ApplicationController
  before_action :authenticate_user!

  def index
    @giveaways = Giveaway.all
  end

  def show
    @giveaway     = Giveaway.find(params[:id])
    @participants = @giveaway.participations
    owner         = Giveaway.find_owner(params[:id])
    @created_by   = User.find(owner)
    # render :plain => @participants.inspect
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

  def take_part
    # render :plain => Giveaway.find(params[:id]).game_name
    giveaway = Giveaway.find(params[:id]).game_name
    Participation.create!(:user_id => current_user.id, 
                          :user_name => current_user.steam_name,
                          :giveaway_name => giveaway,
                          :giveaway_id => params[:id])
    redirect_to :back
  end

  private
  def giveaway_params
    params.require(:giveaway).permit(:game_name)
  end
end
