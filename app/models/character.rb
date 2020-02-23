class Character < ApplicationRecord
    belongs_to :project
    validates :name, presence:true
    validates :age, presence:true
    validates :bio, presence:true

    scope :sort_by_type, -> (type) {reorder("LOWER(#{type})" +" "+ "asc")}

    def self.sort_by_type(type)
        (reorder("LOWER(#{type})" +" "+ "asc"))
    end 
end
