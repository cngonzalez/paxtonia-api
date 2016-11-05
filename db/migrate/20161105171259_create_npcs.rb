class CreateNpcs < ActiveRecord::Migration[5.0]
  def change
    create_table :npcs do |t|
      t.string :name
      t.integer :personality

      t.timestamps
    end
  end
end
