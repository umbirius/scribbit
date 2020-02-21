class Sett < ApplicationRecord
    belongs_to :project
    validates :name, presence:true, uniqueness:true
    validates :location, presence:true
    validates :description, presence:true
end
