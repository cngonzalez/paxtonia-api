class AddActionToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :action, :string
  end
end
