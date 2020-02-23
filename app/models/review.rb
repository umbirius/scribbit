class Review < ApplicationRecord
    # user wanting project reviewed
    belongs_to :reviewer, foreign_key: :reviewer_id, class_name: "User"

    # user reviewing project
    belongs_to :reviewee, foreign_key: :reviewee_id, class_name: "User"
end
