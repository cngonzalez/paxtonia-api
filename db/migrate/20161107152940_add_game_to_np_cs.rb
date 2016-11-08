class AddGameToNpCs < ActiveRecord::Migration[5.0]
  def change
    add_reference :npcs, :game, foreign_key: true
  end
end
