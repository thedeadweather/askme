class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all.order(created_at: :asc)
  end

  def new
    redirect_to root_path, alert: 'Вы уже залогинились' if current_user.present?
    @user = User.new
  end

  def edit
  end

  def create
    redirect_to root_path, alert: 'Вы уже залогинились' if current_user.present?

    @user = User.new(user_params)  # params берем из формы вьюхи users/new.html.erb
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Пользователь зарегистрирован!'
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

    @questions_count = @questions.count
    @answer_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answer_count
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Юзер удален!'
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation,
                                 :avatar_url, :profile_color)
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def authorize_user
    #reject_user определен в application_controller.rb
    reject_user unless @user == current_user
  end
end
