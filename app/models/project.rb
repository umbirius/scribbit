class Project < ApplicationRecord
    belongs_to :user 
    has_many :characters
    # has_many :sett
    # has_many :scenes

end
