class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :project_id
      t.integer :reviewer_id
      t.integer :reviewee_id
      t.boolean :accepted, default: false
      t.boolean :review_status, default: false

      t.timestamps
    end
  end
end
