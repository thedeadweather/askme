module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.user_avatar
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def sklonyator(question)
    ostatok100 = question.size % 100
    ostatok = question.size % 10

    return 'вопросов' if ostatok100 >= 11 && ostatok100 <= 14

    case ostatok
      when 1 then 'вопрос'
      when 2..4 then 'вопроса'
      when 5..9, 0 then 'вопросов'
    end
  end

  def appropriated?(style)
    style.match?(/\A(background: #[\d[:alpha:]]{3,6};?)\z/)
  end

end
