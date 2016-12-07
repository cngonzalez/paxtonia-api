class AddTurnToNpc < ActiveRecord::Migration[5.0]
  def change
    add_reference :npcs, :turn, foreign_key: true
  end
end
