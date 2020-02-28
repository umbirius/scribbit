class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    
    def welcome
        user_session.clear
        @user = current_user
        @posts = Post.all
    end 

    def current_project
        Project.find(user_session["project"]["id"])
    end 


    def create_success(display)
        flash[:success] = []
        flash[:success] << "#{display} has been successfully created"
    end 

    def edit_success(display)
        flash[:success] = []
        flash[:success] << "#{display} has been successfully updated"
    end 

    def destroy_success(display) 
        flash[:success] = []
        flash[:success] << "#{display} has been deleted"
    end 
    protected 

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end 
    


end
