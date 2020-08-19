class CommentsController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        if params[:recipe_id]
            @recipe = Recipe.find_by_id(params[:recipe_id])
            if @recipe
                @comments = @recipe.comments
            else
                flash[:message] = "Post doesn't exist"
                @comments = Comment.all
            end
        else
            @comments = Comment.all 
        end
    end

    def new
        @comment = Comment.new
    end

    def create
        @comment = current_user.comments.build(comment_params)
        if @comment.save
            redirect_to comments_path
        else
            render :new
        end
    end

    def show
        @comment = Comment.find_by_id(params[:id])
    end

    def edit
        @comment = Comment.find_by_id(params[:id])
    end

    def update
        @comment = Comment.find_by_id(params[:id])
        if @comment.update(comment_params)
            redirect_to comments_path
        else
            render :new
        end
    end


end
