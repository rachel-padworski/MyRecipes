class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in


    def index
        if params[:recipe_id] && @recipe = Recipe.find_by_id(params[:recipe_id])
            @comments = @recipe.comments
        else
            @error = "Recipe doesn't exist" if params[:recipe_id]
            @comments = Comment.all
        end
    end

    def new
        if params[:recipe_id] && @recipe = Recipe.find_by_id(params[:recipe_id])
            @comment = @recipe.comments.new
        else
            @error = "Recipe doesn't exist" if params[:recipe_id]
            @comment = Comment.new
        end
    end


    def create
        @recipe = Recipe.find(params[:comment][:recipe_id])
        @comment = current_user.comments.new(comment_params)
        
        if @comment.save
            redirect_to recipe_comment_path(@recipe, @comment)
        else
            render :new
        end
    end

    def show
        @comment = Comment.find(params[:id])
    end

    def edit
    end

    def update
        @comment = Comment.find_by_id(params[:id])
        if @comment.update(comment_params)
            redirect_to comment_path(@comment)
        else
            render :edit
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :recipe_id, :user_id)
    end

end
