class CharactersController < ApplicationController
    def new 
        @character = Character.new
        if params[:project_id]
            @url = project_characters_path
        else 
            @url = characters_path
        end 
    end

    def create 
        if params[:project_id]
            @character = current_project.characters.build(character_params)
        else 
            @character = Character.new(character_params)
            @character.project = Project.find_by(title: params[:character][:project])
        end 

        if @character.save && params[:project_id]
            redirect_to project_characters_url(params[:project_id])
        elsif @character.save
            redirect_to characters_url
        else 
            render :new 
        end
    end

    def index
        if params[:project_id]
            @characters = Project.find(params[:project_id]).characters
            @url = project_characters_path
        else 
            @characters = current_user.characters
            @url = characters_path
        end 
    end

    def show
        if params[:project_id]
            @project = current_project 
            @character = Character.find(params[:id])
            @url = project_characters_path
        else 
            @character = Character.find(params[:id])
            @url = characters_path
        end 
    end

    def edit 
        @character = Character.find(params[:id])
    end 

    def update 
        @character = Character.find(params[:id])
        @character.update(character_params)
        if @character.save
            redirect_to project_characters_url(params[:project_id])
        else 
            render :edit
        end 
    end

    def destroy 
        @character = Character.find(params[:id])
        @character.destroy 
        flash[:notice] = "#{@character.name} has been deleted"
        redirect_to project_characters_path(params[:project_id])
    end

    private 
    
    def character_params
        params.require(:character).permit(:name, :age, :bio)
    end
end
