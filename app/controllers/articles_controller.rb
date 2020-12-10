class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id]) #convert to instance variable
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        # ActionController::Parameters
        # render plain: params[:article].class #{"title"=>"test", "description"=>"testing"}
        @article = Article.new(params.require(:article).permit(:title, :description)) #require top level key of article
        # permit title and description to be used to create the object
        if @article.save
            flash[:notice] = "Article was created successfully."
            redirect_to @article
        else 
            render 'new' #ie. return the new template
        end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render "edit"
        end
    end

end
