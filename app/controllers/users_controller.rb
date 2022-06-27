class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the G Alpha Blog, #{@user.username}, you're now signed up!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User was deleted successfully."
      redirect_to users_path
    else
      flash[:notice] = "User could NOT be deleted"
    end
  end

  private
  def user_params
  params.require(:user).permit(:username, :email, :password)
  end

end
