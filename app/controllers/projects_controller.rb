class ProjectsController < ApplicationController
    def new
        @project = Project.new
    end 

    def create

        @project = current_user.projects.build(project_params)
        @project.save
        redirect_to projects_url(@project)
    end

    def index 
        @projects = current_user.projects
    end

    def show
        @project = Project.find(params[:id])
        user_session[:project] = @project
    end


    private 

    def project_params
        params.require(:project).permit(:title, :form, :genre, :description)
    end 
end
