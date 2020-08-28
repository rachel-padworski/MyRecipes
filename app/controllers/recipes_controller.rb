require "uri"
require "net/http"

class RecipesController < ApplicationController
    
    before_action :redirect_if_not_logged_in

    def index
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @recipes = @user.recipes.alpha
        else
            @error = "That user doesn't exist" if params[:user_id]
            @recipes = Recipe.alpha.includes(:user)
        end
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = current_user.recipes.build(recipe_params)
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            render :new
        end
    end

    def show
        @recipe = Recipe.find_by_id(params[:id])
    end



    private

    def recipe_params 
        params.require(:recipe).permit(:title, :description)
    end

    
   
end

 