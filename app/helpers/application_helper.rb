module ApplicationHelper
  def bootstrap_class_for flash_type
    {success: "alert-success", error:"alert-error", danger: "alert-danger",
      alert: "alert-warning", notice: "alert-info",
      notice_default:"alert-info-default"}[flash_type.to_sym] || flash_type.to_s
  end

  def bootstrap_icon_for flash_type
    {success: "check", error: "times-circle", danger: "ban", alert: "warning",
     notice: "info-circle",
     notice_default: "info-circle"}[flash_type.to_sym] || "question-circle"
  end

  def flash_messages opts = {}
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, id: "flash",
        class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible",
        style: "margin-bottom:10px; margin-top: 10px;") do
        concat content_tag(:button, "x", "aria-hidden": "true", class: "close",
          data: {dismiss: "alert"})
        concat content_tag(:i, nil, class: "icon fa fa-#{bootstrap_icon_for(msg_type)}",
          style:"margin-right: 10px;")
        concat message
      end)
    end
    nil
  end

  def link_to_remove_fields name, f, cssClass
    link_to name, "#",
      onclick: h("remove_fields(this)"), class: cssClass, remote: true
  end

  def link_to_add_fields name, f, association, cssClass, title
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,
      child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to name, "#", onclick: h("add_fields(this, \"#{association}\",
      \"#{escape_javascript(fields)}\")"), class: cssClass, title: title, remote: true
  end

  def datetime date
    I18n.l date, format: :short
  end

  def sortable column, title = nil
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column &&
      sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(sort: column, direction: direction, page: nil),
      {class: css_class}
  end
end
