class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id
      t.integer :reviewee_id
      t.boolean :accepted
      t.boolean :review_status

      t.timestamps
    end
  end
end
