class SessionsController < ApplicationController
    def new
    end
  
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            # user_id here is customisable
            session[:user_id] = user.id #can store info about the user
            flash[:notice] = "Logged in successfully"
            redirect_to user
        else
            # flash.now doesnt persist for one full http request
            # normal flash persist for one full http request
            flash.now[:alert] = "There was something wrong with your login details"
            render "new"
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out"
        redirect_to root_path
    end
  end
  