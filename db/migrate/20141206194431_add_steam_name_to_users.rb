class AddSteamNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :steam_name, :string
  end
end
