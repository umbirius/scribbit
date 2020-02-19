class SettsController < ApplicationController
    def new
        @sett = Sett.new 
    end 
    
    def create 
        @sett = current_project.setts.build(setts_params)
        if @sett.save
            redirect_to project_setts_path(params[:project_id])
        else 
            render :new 
        end
    end 

    def index 
        @setts = current_project.setts
    end 

    def show
        @sett = Sett.find(params[:id])
    end

    def edit 
        @sett = Sett.find(params[:id])

    end 

    def update 
        @sett = Sett.find(params[:id])
        @sett.update(setts_params)
        if @sett.save
            redirect_to project_sett_url(params[:project_id], @sett)
        else 
            render :edit
        end 
    end

    def destroy 
        @sett = Sett.find(params[:id])
        @sett.destroy 
        flash[:notice] = "#{@sett.name} has been deleted"
        redirect_to project_setts_path(params[:project_id])
    end

    private

    def setts_params
        params.require(:sett).permit(:name, :location, :description)
    end 

end
