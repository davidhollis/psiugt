class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :set_menu_items
  before_filter :set_global_sidebar
  
  protected
  def page_not_found
    not_found_page = Page.not_found
    if not_found_page.published?
      [ not_found_page.title, not_found_page.body ]
    else
      [ Page::FALLBACK_PAGE_TITLE, Page::FALLBACK_PAGE_BODY ]
    end
  end
  
  private
  def set_menu_items
    @menu_items = MenuItem.all
  end
  
  def set_global_sidebar
    @home_page = Page.home
    if @home_page.published?
      @global_sidebar = @home_page.sidebar.to_s.html_safe
    else
      @global_sidebar = ''
    end
  end
end
