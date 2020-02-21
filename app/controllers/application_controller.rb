class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    
    def welcome
        user_session.clear
        @user = current_user
    end 

    def current_project
        Project.find(user_session["project"]["id"])
    end 

    protected 

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end 
    


end
