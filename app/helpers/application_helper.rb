module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.user_avatar
    else
      asset_path 'avatar.jpg'
    end
  end
end
