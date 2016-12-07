class CreateNpcTurns < ActiveRecord::Migration[5.0]
  def change
    create_table :npc_turns do |t|
      t.references :npc, foreign_key: true
      t.references :turn, foreign_key: true

      t.timestamps
    end
  end
end
