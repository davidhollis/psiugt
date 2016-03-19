module PagesHelper
  def render_menu(menu_items, current_page_path)
    content_tag(:ul, class: 'nav') do
      (menu_items.map { |item|
        options = {}
        if item.page.slug_path == current_page_path
          options[:class] = 'active'
        end
        content_tag(:li, options) do
          link_to item.page.title, item.page.path
        end
      } +
      [
        content_tag(:li) do
          link_to 'Alumni', 'http://pusog.org/'
        end
      ]).join.html_safe
    end
  end
end
