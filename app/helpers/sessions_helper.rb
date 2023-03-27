module SessionsHelper

    # set session
    def log_in(user)
        session[:user_id] = user.id
    end

    # current_user serve as user in the session
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id:user_id)
        end
    end

    # check if the user is not admin
    def require_login
        unless logged_in?
          flash[:danger] = "You must be logged in to access this page !!!"
          redirect_to login_path
        end
    end
    def not_require_login
        unless !logged_in?
          flash[:danger] = "You must be logged out to access this page !!!"
          redirect_to products_path
        end
    end
    
    def require_admin
        unless !admin?
          flash[:danger] = "Unauthorize Access !!!"
          redirect_to products_path
        end
    end

    def admin?
        current_user.is_admin
    end

    # check if login or not
    def logged_in?
        !current_user.nil?
    end

    # destroy the session
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
