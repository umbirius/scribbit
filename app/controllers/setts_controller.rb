class SettsController < ApplicationController
    def new
        @sett = Sett.new
        if params[:project_id]
            @url = project_setts_path
        else 
            @url = setts_path
        end 
    end 
    
    def create 
        if params[:project_id]
            @sett = current_project.setts.build(sett_params)
        else 
            @sett = Sett.new(sett_params)
            @sett.project = Project.find_by(title: params[:sett][:project])
        end 

        if @sett.save && params[:project_id]
            redirect_to project_setts_url(params[:project_id])
        elsif @sett.save && !params[:project_id]
            redirect_to setts_url
        else 
            render :new 
        end
    end 

    def index 
        if params[:project_id]
            @setts = Project.find(params[:project_id]).setts
            @url = project_setts_path
        else 
            @setts = current_user.setts
            @url = setts_path
        end 
    end 

    def show
        if params[:project_id]
            @project = current_project
            @sett = Sett.find(params[:id])
            @url = project_setts_path
        else 
            @sett = Sett.find(params[:id])
            @url = setts_path
        end 
    end

    def edit 
        @sett = Sett.find(params[:id])
        if params[:project_id]
            @url = project_sett_path(params[:project_id], @sett)
        else 
            @url = sett_path(@sett)
        end 
    end 

    def update 
        @sett = Sett.find(params[:id])
        @sett.update(sett_params)
        if @sett.save && params[:project_id]
            redirect_to project_setts_url(params[:project_id])
        elsif @sett.save && !params[:project_id]
            redirect_to setts_url
        else 
            render :edit
        end 
    end

    def destroy 
        @sett = Sett.find(params[:id])
        @sett.destroy 
        flash[:notice] = "#{@sett.name} has been deleted"
        if params[:project_id]
            redirect_to project_setts_path(params[:project_id])
        else 
            redirect_to setts_path
        end
    end

    private

    def sett_params
        params.require(:sett).permit(:name, :location, :description)
    end 

end
