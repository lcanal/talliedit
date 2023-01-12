class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, required: true
      t.integer :count, default: 0, required: true

      t.timestamps
    end
  end
end
