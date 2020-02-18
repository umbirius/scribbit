class CreateScenes < ActiveRecord::Migration[5.2]
  def change
    create_table :scenes do |t|
      t.string :description
      t.integer :order

      t.timestamps
    end
  end
end
