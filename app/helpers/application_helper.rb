module ApplicationHelper
  include UsersHelper
  
  def full_title(page_title = '')
    base_title = "Fish Review"
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end

def active?(controller_name , action_name)
  return "active" if controller_name == params[:controller] && action_name == params[:action]
end