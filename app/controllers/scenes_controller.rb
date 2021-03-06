class ScenesController < ApplicationController
    
    def new
        @scene = Scene.new
        if params[:project_id]
            @url = project_scenes_path
        else 
            @url = scenes_path
        end 
    end 

    def create
        if params[:project_id]
            @scene = current_project.scenes.build(scene_params)
        else 
            @scene = Scene.new(scene_params)
            @scene.project = Project.find_by(title: params[:scene][:project])
        end 

        if @scene.save && params[:project_id]
            create_success(@scene.title)
            redirect_to project_scenes_url(params[:project_id])
        elsif @scene.save && !params[:project_id]
            create_success(@scene.title)
            redirect_to scenes_url
        else 
            errors_on_saving(@scene)
            render :new 
        end
    end 

    def index
        if params[:project_id]
            @url = project_scenes_path
            if params[:sorts] && params[:sorts][:filter] != "none"
                @filter = params[:sorts][:filter]
                @scenes = Project.find(params[:project_id]).scenes.sort_by_type(@filter)
            else 
                @filter = "none"
                @scenes = Project.find(params[:project_id]).scenes
            end 
        else 
            @url = scenes_path
            if params[:sorts] && params[:sorts][:filter] != "none"
                @filter = params[:sorts][:filter]
                @scenes = current_user.scenes.sort_by_type(@filter)
            else 
                @filter = "none"
                @scenes = current_user.scenes
            end 
        end 
    end

    def show 
        if Scene.find_by(id: params[:id])
            @scene = Scene.find(params[:id])
            redirect_if_not_user_owned(@scene)
            if params[:project_id]
                @project = current_project 
                @url = project_scenes_path
            else 
                @url = scenes_path
            end 
        else 
            unavailable_path
            redirect_to root_url 
        end
    end

    def edit 
        if Scene.find_by(id: params[:id])
            @scene = Scene.find(params[:id])
            redirect_if_not_user_owned(@scene)
            if params[:project_id]
                @url = project_scene_path(params[:project_id], @scene)
            else 
                @url = scene_path(@scene)
            end 
        else 
            unavailable_path
            redirect_to root_url 
        end
    end 

    def update 
        @scene = Scene.find(params[:id])
        @scene.update(scene_params)
        if @scene.save && params[:project_id]
            edit_success(@scene.title)
            redirect_to project_scenes_url(params[:project_id])
        elsif @scene.save && !params[:project_id]
            edit_success(@scene.title)
            redirect_to scenes_url
        else 
            errors_on_saving(@scene)
            ender :edit
        end 
    end

    def destroy 
        if Scene.find_by(id: params[:id])
            @scene = Scene.find(params[:id])
            redirect_if_not_user_owned(@scene)
            @scene.destroy 
            if params[:project_id]
                destroy_success(@scene.title)
                redirect_to project_scenes_path(params[:project_id])
            else 
                destroy_success(@scene.title)
                redirect_to scenes_path
            end
        else 
            unavailable_path
            redirect_to root_url 
        end
    end

    private 
    def scene_params
        params.require(:scene).permit(:title, :description, :order)
    end 
end
