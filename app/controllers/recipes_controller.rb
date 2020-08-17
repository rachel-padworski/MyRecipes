class RecipesController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        
    end

    def new
        @recipe = Recipe.new
    end

    def create
        @recipe = current_user.recipes.build(recipe_params)
        if @recipe.save
            redirect_to recipes_path
        else
            render :new
        end
    end

    def search
        recipes = find_recipe(params[:recipe])
        
        unless recipes
            flash[:alert] = 'Recipe not found'
            render :index
        end

        @recipe = recipes.first
        
    end


    private

    def recipe_params 
        params.require(:recipe).permit(:title, :description)
    end

    def request_api(url)
        response = Jbuilder.get(url, headers: {
            'X-RapidAPI-Host' => URI.parse(url).host,
            'X-RapidAPI-Key' => ENV.fetch('RAPIDAPI_API_KEY')
            }
        )
        return nil if response.status != 200
        JSON.parse(response.body)
    end

    def find_recipe(name)
        request_api("https://mycookbook-io1.p.rapidapi.com/recipes/rapidapi#{URI.encode(name)}")
    end

end
