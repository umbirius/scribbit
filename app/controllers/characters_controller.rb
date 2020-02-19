class CharactersController < ApplicationController
    def new 
        @character = Character.new
    end

    def create 
        @character = current_project.characters.build(character_params)
        if @character.save
            redirect_to project_characters_url(params(:project_id))
        else 
            render :new 
        end
    end

    def index
        @project = current_project
        @characters = current_project.characters
    end

    def show
        @project = current_project 
        @character = Character.find(params[:id])
    end

    def edit 
        @character = Character.find(params[:id])

    end 

    def update 
        @character = Character.find(params[:id])
        if @character.update(character_params)
            redirect_to project_characters_url(params[:project_id])
        else 
            render :edit
        end 
    end

    private 
    
    def character_params
        params.require(:character).permit(:name, :age, :bio)
    end
end
