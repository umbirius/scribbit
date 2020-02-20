class CharactersController < ApplicationController
    def new 
        @character = Character.new
    end

    def create 
        @character = current_project.characters.build(character_params)
        if @character.save
            redirect_to project_characters_url(params[:project_id])
        else 
            render :new 
        end
    end

    def index
        byebug
        if params[:user_id]
            @characters = User.find(params[:user_id]).characters
            @url = project_characters_path
        else 
            @characters = current_user.characters
            @url = characters_path
        end 
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
