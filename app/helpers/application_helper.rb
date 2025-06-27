module ApplicationHelper
  def flash_class_for(type)
    case type
    when "notice" then "alert-success"
    when "alert", "error" then "alert-danger"
    else "alert-info"
    end
  end
end
