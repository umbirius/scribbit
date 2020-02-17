class CharactersController < ApplicationController
    def new 
        @character = Character.new
    end

    def create 
        byebug
        @character = Project.current_project.character.build(character_params)
        byebug
    end

    def index 
    end

    private 
    
    def character_params
        params.require(:character).permit(:name, :age, :bio)
    end
end
