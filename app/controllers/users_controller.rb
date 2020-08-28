class UsersController < ApplicationController

    def index
        @user = User.find(params[:id])

    end
# I need to get the 

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            session[:user_id] = @user.id 
            redirect_to @user
        else
            render :new
        end
    end

    def show
        redirect_if_not_logged_in
        @user = User.find_by_id(params[:id])
        redirect_to '/' if !@user
    end



    private

    def user_params
        params.require(:user).permit(:user_name, :email, :password)
    end

end
