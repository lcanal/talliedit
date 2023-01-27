class AddTeamToCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :team, null: true, foreign_key: true
  end
end
