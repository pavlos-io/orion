class AddGiveawayNameToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :giveaway_name, :string
  end
end
