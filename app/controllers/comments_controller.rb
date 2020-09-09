class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in
   


    def index
        if params[:recipe_id] && @recipe = Recipe.find_by_id(params[:recipe_id])
            @comments = @recipe.comments
        elsif current_user
            @comments = current_user.comments.all
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
            @error = @comment.errors.full_messages
            render :new
        end
    end

    def show
        @comment = Comment.find(params[:id])
    end

    def edit
        @comment = Comment.find(params[:id])
    end

    def update
        @comment = current_user.comments.find(params[:id])
     
        if @comment.update(comment_params)
            redirect_to comment_path(@comment)
        else
            @error = @comment.errors.full_messages
            render :edit
        end
    end

    def destroy
        @comment = current_user.comments.find(params[:id])
        if @comment.destroy
            flash[:success] = "Your comment was successfully deleted."
            redirect_to recipes_path
        else
            @error = @comment.errors.full_messages
            render :edit
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :recipe_id, :user_id)
    end

end
