class UsersController < ApplicationController


  get '/signup' do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :"users/new"
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect to "/signup"
    else
      @user = User.create(params)
      session[:user_id] = @user.id
      redirect to "/tweets/index"
    end
  end

  get '/login' do
    if session[:user_id]
      redirect to "/tweets"
    else
      erb :index
    end
  end

  post '/login' do

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/tweets"

    else
      redirect to "/login"
    end
  end



end
