module ApplicationHelper

  def current_user?(user)
    current_user == user
  end

  def is_active?(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def foto(user)
    unless user.blank?
      user.image? ? image_tag(user.image, class: 'img-circle img-thumbnail user_link') : content_tag(:i, "", class: 'fa fa-user img-thumbnail img-circle ') 
    else
      content_tag(:i, "", class: 'fa fa-user img-thumbnail img-circle ')
    end
  end

  def review_user_nick(user)
    if user.present?
      user.nick
    else
      "User deleted account"
    end
  end
end
