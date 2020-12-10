class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy] #runs set article before running this action

    def show
         #convert to instance variable
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
        
    end

    def create
        # ActionController::Parameters
        # render plain: params[:article].class #{"title"=>"test", "description"=>"testing"}
        @article = Article.new(article_params) #require top level key of article
        @article = User.first
        # permit title and description to be used to create the object
        if @article.save
            flash[:notice] = "Article was created successfully."
            redirect_to @article
        else 
            render 'new' #ie. return the new template
        end
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render "edit"
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private
    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end
end
