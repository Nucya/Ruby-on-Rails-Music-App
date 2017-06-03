class UsersController < ApplicationController
  def index
  end

  def home
    @logged_in_user = User.find session[:user_id]
  end

  def login_user
    user = User.find_by_email params[:email]

    if user.nil?
      flash[:messages] = ['User Not Found']
      redirect_to '/users/login'
    else

      if user.authenticate params[:password]
        flash[:messages] = ['Logged In']
        session[:user_id] = user.id
        redirect_to '/users/home'
      else
        flash[:messages] = ['Incorrect Password']
        redirect_to '/users/login'
      end
    end
  end

  def create
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]

    if user.save
      flash[:messages] = ['Success']
    else
      flash[:messages] = user.errors.full_message
    end
    redirect_to '/users/login'
  end
  def songs
    @users = User.all
  end

  def update

  end
end
