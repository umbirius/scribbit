class Scene < ApplicationRecord
    belongs_to :project
    validates :title, presence:true, uniqueness:true
    validates :description, presence:true
    validates :order, uniqueness:true, numericality: true, allow_nil:true 
    
    scope :sort_by_type, -> (type) {reorder("LOWER(#{type})" +" "+ "asc")}

    def self.sort_by_type(type)
        (reorder("LOWER(#{type})" +" "+ "asc"))
    end 
end
