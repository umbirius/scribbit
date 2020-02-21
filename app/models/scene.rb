class Scene < ApplicationRecord
    belongs_to :project
    validates :title, presence:true, uniqueness:true
    validates :description, presence:true
    validates :order, uniqueness:true, numericality: true, allow_nil:true 
end
