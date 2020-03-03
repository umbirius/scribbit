class ProjectsController < ApplicationController
    def new
        @project = Project.new
    end 

    def create
        @project = current_user.projects.build(project_params)
        if @project.save
            create_success(@project.title)
            redirect_to project_url(@project)
        else 
            errors_on_saving(@project)
            render :new
        end
    end

    def index 
        if params[:sorts] && params[:sorts][:filter] != "none"
            @filter = params[:sorts][:filter]
            @projects = current_user.projects.sort_by_type(@filter)
        else 
            @filter = "none"
            @projects = current_user.projects 
        end 
    end

    def show
        if Project.find_by(id: params[:id])
            @project = Project.find(params[:id])
            redirect_if_not_user_owned(@project)
        else 
            unavailable_path
            redirect_to root_url 
        end
    end

    def edit 
        if Project.find_by(id: params[:id])
            @project = Project.find(params[:id])
            redirect_if_not_user_owned(@project)
        else 
            unavailable_path
            redirect_to root_url 
        end
    end 

    def update 
        @project = Project.find(params[:id])
        @project.update(project_params)
        if @project.save
            edit_success(@project.title)
            redirect_to project_url
        else 
            errors_on_saving(@project)
            render :edit
        end 
    end

    def destroy 
        if Project.find_by(id: params[:id])
            @project = Project.find(params[:id])
            redirect_if_not_user_owned(@project)
            @project.destroy 
            destroy_success(@project.title)
            redirect_to projects_path
        else 
            unavailable_path
            redirect_to root_url 
        end

    end

    private 

    def project_params
        params.require(:project).permit(:title, :form, :genre, :description)
    end 
end
