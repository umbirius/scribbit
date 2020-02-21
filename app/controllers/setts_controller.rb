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

    def sett_params
        params.require(:sett).permit(:name, :location, :description)
    end 

end
