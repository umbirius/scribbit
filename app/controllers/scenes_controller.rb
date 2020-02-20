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
            @scene = Scene.new(scenes_params)
            @scene.project = Project.find_by(title: params[:scene][:project])
        end 

        if @scene.save && params[:project_id]
            redirect_to project_scenes_url(params[:project_id])
        elsif @scene.save && !params[:project_id]
            redirect_to scenes_url
        else 
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

    end 

    def update 
        @scene = Scene.find(params[:id])
        @scene.update(scenes_params)
        if @scene.save
            redirect_to project_scene_url(params[:project_id], @scene )
        else 
            render :edit
        end 
    end

    def destroy 
        @scene = Scene.find(params[:id])
        @scene.destroy 
        flash[:notice] = "#{@scene.title} has been deleted"
        redirect_to project_scenes_path(params[:project_id])
    end
    private 
    def scenes_params
        params.require(:scene).permit(:title, :description, :order)
    end 
end
