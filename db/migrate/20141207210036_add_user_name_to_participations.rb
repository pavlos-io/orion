class AddUserNameToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :user_name, :string
  end
end
