class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have successfully updated."
      redirect_to @user
    else
      render :edit
    end
  end

  def bookmarks
    @user = User.find(params[:id])
    @bookmarks = @user.bookmarks.includes(:book)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@guest.com"
      redirect_to user_path(@user), notice: "You can not move to a editing page"
    end
  end

end