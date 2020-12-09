class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id]) #convert to instance variable
    end
end
