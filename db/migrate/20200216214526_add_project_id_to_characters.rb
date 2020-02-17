class AddProjectIdToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :project_id, :string
  end
end
