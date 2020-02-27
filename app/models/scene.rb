class Scene < ApplicationRecord
    belongs_to :project
    validates :title, presence:true, uniqueness: {scope: :project}
    validates :description, presence:true
    validates :order, uniqueness: {scope: :project}, numericality: true, allow_nil:true 
    
    scope :sort_by_type, -> (type) {joins(:project).order("LOWER(#{type})")}
end
