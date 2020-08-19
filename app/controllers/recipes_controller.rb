require "uri"
require "net/http"

class RecipesController < ApplicationController
    
    before_action :redirect_if_not_logged_in

    def index
        @restaurants = Restaurant.all
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
        search["recipes"].each do |recipe|
            Recipe.create_recipes(recipe)
        end

        recipes = find_recipe(params[:recipe])
        if recipes
            render :index
        else
            flash[:alert] = 'Recipe not found'
            render :search
        end
    end


    private

    def recipe_params 
        params.require(:recipe).permit(:title, :description)
    end

    def find_recipe(name)
        url = URI("https://api.edamam.com/search?q=#{name}&app_id=#{ENV['APP_ID']}&app_key=#{ENV['API_KEY']}")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true

        request = Net::HTTP::Get.new(url)

        response = https.request(request)
        res=JSON.parse(response.read_body)  
    end

   
end

    #url to the recipe instructions:
    # recipes["hits"][0]["recipe"]["url"]

    #to the recipe title:
    # recipes["hits"][0]["recipe"]["label"]

    #to the recipe image:
    # recipes["hits"][1]["recipe"]["image"]