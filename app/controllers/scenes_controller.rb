class ScenesController < ApplicationController
    
    def new
        @scene = Scene.new
    end 

    def create
        @scene = current_project.scenes.build(scenes_params)
        @scene.save
        redirect_to project_scenes_url(params[:project_id])
    end 

    def index
        @scenes = current_project.scenes
    end

    def show 
        @scene = Scene.find(params[:id])
    end

    private 
    def scenes_params
        params.require(:scene).permit(:title, :description, :order)
    end 
end
