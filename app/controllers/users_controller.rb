class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
    end



    private

    def user_params
        params.require(:user).permit(:user_name, :email, :password)
    end

end
