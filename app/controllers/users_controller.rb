class UsersController < ApplicationController

  def index
    @users = [
      User.new(
        id: 1,
        name: 'Alx',
        username: 'usrnumbavan',
        avatar_url: ''
      ),
      User.new(id: 2, name: 'Vasily', username: 'funfun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(name: "bob", username: "superman")
    # массив вопросов (отображается с помощью partial views/questions/_question)
    @questions = [
      Question.new(text: 'How much in the fish?', created_at: Date.parse('01.05.2020'))
    ]
    # создается с помощью формы form-for в show.html.erb
    @new_question = Question.new
  end
end
