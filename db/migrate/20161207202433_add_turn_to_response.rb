class AddTurnToResponse < ActiveRecord::Migration[5.0]
  def change
    add_reference :responses, :turn, foreign_key: true
  end
end
