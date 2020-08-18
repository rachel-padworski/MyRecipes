require "uri"
require "net/http"

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
       
        if recipes
            render :index
        else
            flash[:alert] = 'Recipe not found'
            render :search
        end

        @recipe = recipes.first 
    end


    private

    def recipe_params 
        params.require(:recipe).permit(:title, :description)
    end

    def find_recipe(name)
        # request_api("https://mycookbook-io1.p.rapidapi.com/recipes/rapidapi#{URI.encode(name)}")
     

        url = URI("https://api.edamam.com/search?q=#{name}&app_id=#{ENV['APP_ID']}&app_key=#{ENV['API_KEY']}")

        https = Net::HTTP.new(url.host, url.port);
        https.use_ssl = true

        request = Net::HTTP::Get.new(url)

        response = https.request(request)
        res=JSON.parse(response.read_body)
        # puts response.read_body
        name = res["hits"][1]["recipe"]["label"]
    end

end
