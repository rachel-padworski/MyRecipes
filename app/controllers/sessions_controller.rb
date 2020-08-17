class SessionsController < ApplicationController

    def create
        user = User.find_by(user_name: params[:user][:user_name])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id 
            redirect_to user_path(user) 
        else
            flash[:message] = "Incorrect login information"
            redirect_to '/login'
        end
    end

    def destroy
        session.clear
        redirect_to root_path
    end


end