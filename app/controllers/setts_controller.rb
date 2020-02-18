class SettsController < ApplicationController
    def new
        @sett = Sett.new 
    end 
    
    def create 
        @sett = current_project.build(setts_params)
        @sett.save
        redirect_to project_setts_path(params[:project_id])
    end 

    def index 
    end 

    def show
    end

    private

    def setts_params
        params.require(:sett).permit(:name, :location, :description)
    end 

end
