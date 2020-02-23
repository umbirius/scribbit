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
        elsif @character.save && !params[:project_id]
            redirect_to characters_url
        else 
            flash[:errors] = @character.errors.full_messages
            render :new 
        end
    end

    def index
        if params[:project_id]
            @url = project_characters_path

            if params[:sorts] && params[:sorts][:filter] != "none"
                @filter = params[:sorts][:filter]
                @characters = Project.find(params[:project_id]).characters.sort_by_type(@filter)
            else 
                @filter = "none"
                @characters = Project.find(params[:project_id]).characters
            end 
        else 
            @url = characters_path

            if params[:sorts] && params[:sorts][:filter] != "none"
                @filter = params[:sorts][:filter]
                @characters = current_user.characters.sort_by_type(@filter)
            else 
                @filter = "none"
                @characters = current_user.characters
            end 
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
        if params[:project_id]
            @url = project_character_path(params[:project_id], @character)
        else 
            flash[:errors] = @character.errors.full_messages
            @url = character_path(@character)
        end 
    end 

    def update 
        @character = Character.find(params[:id])
        @character.update(character_params)
        if @character.save && params[:project_id]
            redirect_to project_characters_url(params[:project_id])
        elsif @character.save && !params[:project_id]
            redirect_to characters_url
        else 
            render :edit
        end 
    end

    def destroy 
        @character = Character.find(params[:id])
        @character.destroy 
        flash[:notice] = "#{@character.name} has been deleted"
        if params[:project_id]
            redirect_to project_characters_path(params[:project_id])
        else 
            redirect_to characters_path
        end
    end

    private 
    
    def character_params
        params.require(:character).permit(:name, :age, :bio)
    end
end
