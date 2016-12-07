class AddResultToTurn < ActiveRecord::Migration[5.0]
  def change
    add_column :turns, :result, :string
  end
end
