class CharactersController < ApplicationController
    def new 
        @character = Character.new
    end

    def create 
        @project = current_project
        @character = current_project.characters.build(character_params)
        @character.save
        redirect_to project_characters_url(@project)
    end

    def index
        @project = current_project
        @characters = current_project.characters
    end

    def show
        @project = current_project 
        @character = Character.find(params[:id])
    end

    private 
    
    def character_params
        params.require(:character).permit(:name, :age, :bio)
    end
end
