class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :hero_reputation

      t.timestamps
    end
  end
end
