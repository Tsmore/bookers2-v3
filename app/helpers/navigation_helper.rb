module NavigationHelper
  def nav_item(path, icon_class, text, options = {})
    content_tag(:li, class: 'nav-item') do
      link_to path, {class: 'nav-link text-light'}.merge(options) do
        content_tag(:i, '', class: icon_class) + ' ' + text
      end
    end
  end
end
