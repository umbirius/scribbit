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
        byebug
        if params[:project_id]
            @scene = current_project.scenes.build(scene_params)
        else 
            @scene = Scene.new(scene_params)
            @scene.project = Project.find_by(title: params[:scene][:project])
        end 

        if @scene.save && params[:project_id]
            redirect_to project_scenes_url(params[:project_id])
        elsif @scene.save && !params[:project_id]
            redirect_to scenes_url
        else 
            flash[:errors] = @scene.errors.full_messages
            render :new 
        end
    end 

    def index
        if params[:project_id]
            @scenes = Project.find(params[:project_id]).scenes
            @url = project_scenes_path
        else 
            @scenes = current_user.scenes
            @url = scenes_path
        end 
    end

    def show 
        @scene = Scene.find(params[:id])

        if params[:project_id]
            @project = current_project 
            @scene = Scene.find(params[:id])
            @url = project_scenes_path
        else 
            @scene = Scene.find(params[:id])
            @url = scenes_path
        end 
    end

    def edit 
        @scene = Scene.find(params[:id])
        @scene = Scene.find(params[:id])
        if params[:project_id]
            @url = project_scene_path(params[:project_id], @scene)
        else 
            flash[:errors] = @scene.errors.full_messages
            @url = scene_path(@scene)
        end 
    end 

    def update 
        @scene = Scene.find(params[:id])
        @scene.update(scene_params)
        if @scene.save && params[:project_id]
            redirect_to project_scenes_url(params[:project_id])
        elsif @scene.save && !params[:project_id]
            redirect_to scenes_url
        else 
            render :edit
        end 
    end

    def destroy 
        @scene = Scene.find(params[:id])
        @scene.destroy 
        flash[:notice] = "#{@scene.title} has been deleted"
        if params[:project_id]
            redirect_to project_scenes_path(params[:project_id])
        else 
            redirect_to scenes_path
        end
    end
    private 
    def scene_params
        params.require(:scene).permit(:title, :description, :order)
    end 
end
