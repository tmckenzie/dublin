module ApplicationHelper

  def main_nav_link(name, url, is_current_page = false)
    selected_class = is_current_page ? "selected" : ""
    link_to(content_tag(:em, name), url, :class => selected_class)
  end
  
  def highlight_campaign_nav?(controller_name)
    (controller_name == "campaigns" || controller_name == "campaign_builder" || controller_name == 'messages')
  end

  def get_season(date)
    season = case date.month
               when 3..5
                 "Spring"
               when 6..8
                 "Summer"
               when 9..11
                 "Fall"
               when 12, 1..2
                 "Winter"
             end
    "#{season} #{date.year}"
  end

  def selected_tab_class_if(statement)
    "ui-tabs-selected ui-state-active" if statement
  end
end
