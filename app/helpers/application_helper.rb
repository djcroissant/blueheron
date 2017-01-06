module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_name = "")
    base_title = "Blue Heron Marketplace"
    return base_title if page_name.blank?
    "#{page_name} | #{base_title}"
  end
end
