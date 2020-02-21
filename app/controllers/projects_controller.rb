class ProjectsController < ApplicationController
    def new
        @project = Project.new
    end 

    def create
        @project = current_user.projects.build(project_params)
        if @project.save
            redirect_to project_url(@project)
        else 
            flash[:errors] = @project.errors.full_messages
            render :new
        end
    end

    def index 
        @projects = current_user.projects
    end

    def show
        @project = Project.find(params[:id])
        @c_l = @project.characters.length
        @s_l = @project.setts.length
        @sc_l = @project.scenes.length
        user_session[:project] = @project
    end

    def edit 
        @project = Project.find(params[:id])

    end 

    def update 
        @project = Project.find(params[:id])
        @project.update(project_params)
        if @project.save
            redirect_to project_url
        else 
            flash[:errors] = @project.errors.full_messages
            render :edit
        end 
    end

    def destroy 
        @project = Project.find(params[:id])
        @project.destroy 
        flash[:notice] = "#{@project.title} has been deleted"
        redirect_to projects_path
    end

    private 

    def project_params
        params.require(:project).permit(:title, :form, :genre, :description)
    end 
end
