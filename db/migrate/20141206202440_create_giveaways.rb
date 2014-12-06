class CreateGiveaways < ActiveRecord::Migration
  def change
    create_table :giveaways do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :game_name

      t.timestamps
    end
  end
end
