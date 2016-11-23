class AddPassToResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :pass, :boolean
  end
end
