class UsersController < ApplicationController

  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(name: "Ali", username: "Baba")
    @questions = [
      Question.new(text: 'Lorem ipsum', created_at: Date.parse('01.05.2020'))
    ]
  end
end
