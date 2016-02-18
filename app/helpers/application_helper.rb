module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Forum"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def link_user(inputid)
    user = User.find_by(id: inputid)
    if user.try(:admin?)
      link_to user.username, user_path(inputid), class: "admin"
    else
      link_to user.username, user_path(inputid)
    end
  end
end