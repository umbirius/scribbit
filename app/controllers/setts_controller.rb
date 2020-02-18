class SettsController < ApplicationController
    def new
        @sett = Sett.new 
    end 
    
    def create 
        @sett = current_project.setts.build(setts_params)
        @sett.save
        redirect_to project_setts_path(params[:project_id])
    end 

    def index 
        @setts = current_project.setts
    end 

    def show
        @sett = Sett.find(params[:id])
    end

    private

    def setts_params
        params.require(:sett).permit(:name, :location, :description)
    end 

end
