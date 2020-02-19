class ScenesController < ApplicationController
    
    def new
        @scene = Scene.new
    end 

    def create
        @scene = current_project.scenes.build(scenes_params)
        if @scene.save
            redirect_to project_scenes_url(params[:project_id])
        else 
            render :new
        end 
    end 

    def index
        @scenes = current_project.scenes
    end

    def show 
        @scene = Scene.find(params[:id])
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
