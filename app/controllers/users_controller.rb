class UsersController < ApplicationController

  before_action :load_user, except: [:index, :new, :create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)  # params берем из формы вьюхи users/new.html.erb
    if @user.save
      redirect_to root_url, notice: 'Пользователь зарегистрирован!'
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены!'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation,
                                 :avatar_url)
  end

  def load_user
    @user ||= User.find params[:id]
  end
end
