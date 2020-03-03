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
            create_success(@sett.name)
            redirect_to project_setts_url(params[:project_id])
        elsif @sett.save && !params[:project_id]
            create_success(@sett.name)
            redirect_to setts_url
        else 
            errors_on_saving(@sett)
            render :new 
        end
    end 

    def index 
        if params[:project_id]
            @url = project_setts_path

            if params[:sorts] && params[:sorts][:filter] != "none"
                @filter = params[:sorts][:filter]
                @setts = Project.find(params[:project_id]).setts.sort_by_type(@filter)
            else 
                @filter = "none"
                @setts = Project.find(params[:project_id]).setts
            end 
        else 
            @url = setts_path

            if params[:sorts] && params[:sorts][:filter] != "none"
                @filter = params[:sorts][:filter]
                @setts = current_user.setts.sort_by_type(@filter)
            else 
                @filter = "none"
                @setts = current_user.setts
            end 
        end 
    end 

    def show
        if Sett.find_by(id: params[:id])
            @sett = Sett.find(params[:id])
            redirect_if_not_user_owned(@sett)
            if params[:project_id]
                @project = current_project
                @url = project_setts_path
            else 
                @url = setts_path
            end 
        else 
            unavailable_path
            redirect_to root_url 
        end
    end

    def edit 
        if Sett.find_by(id: params[:id])
            @sett = Sett.find(params[:id])
            redirect_if_not_user_owned(@sett)
            if params[:project_id]
                @url = project_sett_path(params[:project_id], @sett)
            else 
                @url = sett_path(@sett)
            end 
        else 
            unavailable_path
            redirect_to root_url 
        end

    end 

    def update 
        @sett = Sett.find(params[:id])
        @sett.update(sett_params)
        if @sett.save && params[:project_id]
            update_success(@sett.name)
            redirect_to project_setts_url(params[:project_id])
        elsif @sett.save && !params[:project_id]
            update_success(@sett.name)
            redirect_to setts_url
        else 
            errors_on_saving(@sett)
            render :edit
        end 
    end

    def destroy 
        if Sett.find_by(id: params[:id])
            @sett = Sett.find(params[:id])
            redirect_if_not_user_owned(@sett)
            @sett.destroy 
            if params[:project_id]
                destroy_success(@sett.name)
                redirect_to project_setts_path(params[:project_id])
            else 
                redirect_to setts_path
            end
        else 
            unavailable_path
            redirect_to root_url 
        end
    end

    private

    def sett_params
        params.require(:sett).permit(:name, :location, :description)
    end 

end
