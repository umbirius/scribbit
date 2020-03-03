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

    def errors_on_saving(object)
        flash.now[:errors] = object.errors.full_messages
    end 

    def unauthorized_path 
        flash[:errors] = []
        flash[:errors] << "Unauthorized path"
    end

    protected 

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end 

    def redirect_if_not_user_owned(object)
        if object.user != current_user
            unauthorized_path
            redirect_to root_url 
        end 
    end

    
    


end
