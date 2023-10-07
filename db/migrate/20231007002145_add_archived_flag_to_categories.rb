class AddArchivedFlagToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :archived, :boolean, default: false
  end
end
