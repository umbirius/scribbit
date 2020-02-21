class Project < ApplicationRecord
    belongs_to :user 
    has_many :characters
    has_many :setts
    has_many :scenes
    validates :title, presence:true, uniqueness:true
    validates :description, presence:true
    validates :form, presence:true
    validates :genre, presence:true
end
