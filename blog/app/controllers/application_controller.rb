class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_categories

    protected

    def authenticate_editor!
        redirect_to root_path unless user_signed_in? && current_user.is_editor?
    end

    def authenticate_admin!
        redirect_to root_path unless user_signed_in? && current_user.is_admin?
    end
    
    def configure_permitted_parameters
        #Forma para Rails 5, antes se usaba for en vez de permit
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email, :password])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
    end

    private

    def set_categories
        @categories = Category.all
    end
end
