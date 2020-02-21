class Character < ApplicationRecord
    belongs_to :project
    validates :name, presence:true
    validates :age, presence:true
    validates :bio, presence:true
end
