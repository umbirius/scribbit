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
            create_success(@character.name)
            redirect_to project_characters_url(params[:project_id])
        elsif @character.save && !params[:project_id]
            create_success(@character.name)
            redirect_to characters_url
        else 
            errors_on_saving(@character)
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
        if Character.find_by(id: params[:id])
            @character = Character.find(params[:id])
            redirect_if_not_user_owned(@character)
            if params[:project_id]
                @project = current_project 
                @url = project_characters_path
            else 
                @url = characters_path
            end 
        else 
            unavailable_path
            redirect_to root_url 
        end
    end

    def edit 
        if Character.find_by(id: params[:id])
            @character = Character.find(params[:id])
            redirect_if_not_user_owned(@character)
    
            if params[:project_id]
                @url = project_character_path(params[:project_id], @character)
            else 
                @url = character_path(@character)
            end 
        else 
            unavailable_path
            redirect_to root_url 
        end

    end 

    def update 
        @character = Character.find(params[:id])
        @character.update(character_params)
        if @character.save && params[:project_id]
            edit_success(@character.name)
            redirect_to project_characters_url(params[:project_id])
        elsif @character.save && !params[:project_id]
            edit_success(@character.name)
            redirect_to characters_url
        else 
            errors_on_saving(@character)
            render :edit
        end 
    end

    def destroy 
        if Character.find_by(id: params[:id])
            @character = Character.find(params[:id])
            redirect_if_not_user_owned(@character)
            @character.destroy 
            if params[:project_id]
                destroy_success(@character.name)
                redirect_to project_characters_path(params[:project_id])
            else 
                destroy_success(@character.name)
                redirect_to characters_path
            end
        else 
            unavailable_path
            redirect_to root_url 
        end
    end

    private 
    
    def character_params
        params.require(:character).permit(:name, :age, :bio)
    end
end
