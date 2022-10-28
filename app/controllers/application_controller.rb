class ApplicationController < ActionController::Base
    #CHRLL
    helper_method :current_user, :logged_in?
    
    def current_user
        @current_user= User.find_by(session_token: session:[session_token])
    end

    def required_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def required_logged_out
        redirect_to user_url(current_user.id) if logged_in?
    end

    def login(user)
        session[:session_token]= user.reset_session_token!
    end

    def logout
        session[:session_token]= nil
        current_user.reset_session_token!
        @current_user= nil

    end

    

end
