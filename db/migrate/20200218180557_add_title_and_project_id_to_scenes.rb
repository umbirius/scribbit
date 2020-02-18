class AddTitleAndProjectIdToScenes < ActiveRecord::Migration[5.2]
  def change
    add_column :scenes, :title, :string
    add_column :scenes, :project_id, :integer
  end
end
