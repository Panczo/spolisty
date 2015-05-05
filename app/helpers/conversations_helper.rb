module ConversationsHelper

  def mailbox_section(title, current_box, opts = {})
    opts[:class] = opts.fetch(:class, '')
    opts[:class] += ' active' if title.downcase == current_box
    content_tag :li, link_to(title.capitalize, user_conversations_path(current_user, box: title.downcase)), opts
  end

end
