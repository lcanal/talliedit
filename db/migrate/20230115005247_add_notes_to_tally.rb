class AddNotesToTally < ActiveRecord::Migration[7.0]
  def change
    add_column :tallies, :notes, :string
  end
end
