class Character < ApplicationRecord
    belongs_to :project
    validates :name, presence:true
    validates :age, presence:true
    validates :bio, presence:true

    scope :sort_by_type, -> (type) {joins(:project).order("LOWER(#{type})")}

end
