class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        @user= User.find_by
        (username: params[:user][:username],
        password: params[:user][:password])

        if @user
            login(@user)
            redirect_to user_url(@user.id)
        else
            flash[:errors]= ["Invalid credentials"]
            redirect_to new_session_url
        end
    end


    def destroy

    end



end