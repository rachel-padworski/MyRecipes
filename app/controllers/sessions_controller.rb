class SessionsController < ApplicationController

    def index
        @recipes = Recipe.all
    end

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

    def google
        @user = User.find_or_create_by(email: auth["info"]["email"]) do |user|
            user.user_name = auth["info"]["first_name"]
            user.password = SecureRandom.hex(10)
        end
        if @user.save
            session[:user_id] = @user.id 
            redirect_to user_path(@user)
        else
            redirect_to '/'
        end
    end

    

    private

    def auth
        request.env['omniauth.auth']
    end
end