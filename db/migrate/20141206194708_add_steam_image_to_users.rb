class AddSteamImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :steam_image, :string
  end
end
