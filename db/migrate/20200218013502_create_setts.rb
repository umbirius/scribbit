class CreateSetts < ActiveRecord::Migration[5.2]
  def change
    create_table :setts do |t|
      t.string :name
      t.string :location
      t.string :description
      t.integer :project_id

      t.timestamps
    end
  end
end
