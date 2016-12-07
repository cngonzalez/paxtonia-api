class RemoveNpcFromResponse < ActiveRecord::Migration[5.0]
  def change
    remove_column(:responses, :npc_id)
  end
end
