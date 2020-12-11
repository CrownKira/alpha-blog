class ApplicationController < ActionController::Base
    # makes the methods avaible to the view as well
    helper_method :current_user, :logged_in?

    def current_user
        # memoization
        # ||= : @current_user assign to rhs if undefined
        # session methods from applciation controller is exposed by rails, so it is accessible here
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user #turn current_user into a boolean
    end

    def require_user
        if !logged_in?
            flash[:alert] = "You must be logged in to perform the action"
            redirect_to login_path
        end
    end
end
