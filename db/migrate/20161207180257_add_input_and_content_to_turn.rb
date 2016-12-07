class AddInputAndContentToTurn < ActiveRecord::Migration[5.0]
  def change
    add_column :turns, :input, :string
    add_column :turns, :content, :string
  end
end
