class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.text :content
      t.belongs_to :npc, foreign_key: true
      t.text :input
      t.integer :hero_reputation

      t.timestamps
    end
  end
end
