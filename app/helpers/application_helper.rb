module ApplicationHelper
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
