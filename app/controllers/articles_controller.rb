class ArticlesController < ApplicationController
    # order matters for before_action
    before_action :set_article, only: [:show, :edit, :update, :destroy] #runs set article before running this action
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
         #convert to instance variable
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
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

    def require_same_user
        if current_user != @article.user
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
end
