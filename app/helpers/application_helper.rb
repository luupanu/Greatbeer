module ApplicationHelper
  def ban_button(user)
    return unless current_user.admin

    button_text = user.banned ? 'Unban user' : 'Ban user'
    button_class = user.banned ? "btn btn-success" : "btn btn-danger"

    ban = link_to(button_text, toggle_ban_status_user_path, method: :post, class: button_class)
    raw("#{ban} </br>")
  end

  def edit_and_destroy_buttons(item)
    return unless current_user

    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")
    del = link_to('Delete', item, method: :delete,
                                  data: { confirm: 'Are you sure?' },
                                  class: "btn btn-danger")
    raw("</br> #{edit} #{del}")
  end

  def round(number)
    number.round(1)
  end
end
