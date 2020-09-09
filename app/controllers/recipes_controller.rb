
class RecipesController < ApplicationController
    
    before_action :redirect_if_not_logged_in

    def index
        if params[:q]
            @recipes = Recipe.search(params[:q])
        else
            @recipes = Recipe.alpha.all
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

    def edit
        @recipe = Recipe.find(params[:id])
    end

    def update
        @recipe = current_user.recipes.find(params[:id])
     
        if @recipe.update(recipe_params)
            redirect_to recipe_path(@recipe)
        else
            @error = @recipe.errors.full_messages
            render :edit
        end
    end

    private

    def recipe_params 
        params.require(:recipe).permit(:title, :description)
    end

    
   
end

 