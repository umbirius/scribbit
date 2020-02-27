class Sett < ApplicationRecord
    belongs_to :project
    validates :name, presence:true, uniqueness:true
    validates :location, presence:true
    validates :description, presence:true

    scope :sort_by_type, -> (type) {joins(:project).order("LOWER(#{type})")}

end
